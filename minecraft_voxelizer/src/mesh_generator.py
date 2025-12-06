import torch
import numpy as np
import os
from PIL import Image

import sys
import os

# Get the absolute path to the TripoSR folder inside your project
current_dir = os.path.dirname(os.path.abspath(__file__))
triposr_path = os.path.join(current_dir, "..", "TripoSR")
sys.path.append(triposr_path)

# Now standard imports will work
import torch
from tsr.system import TSR
from tsr.utils import remove_background, resize_foreground
from rembg import remove

class MeshGenerator:
    def __init__(self):
        self.device = "cuda" if torch.cuda.is_available() else "cpu"
        print(f"Loading TripoSR on {self.device}...")
        
        # Load the pretrained TripoSR model
        # This will auto-download weights (~6GB) on first run
        self.model = TSR.from_pretrained(
            "stabilityai/TripoSR",
            config_name="config.yaml",
            weight_name="model.ckpt",
        )
        self.model.to(self.device)

    def preprocess_image(self, image_path):
        """
        Removes background and centers the object.
        """
        print(f"Preprocessing {image_path}...")
        input_image = Image.open(image_path).convert("RGB")
        
        # 1. Remove background using Rembg
        # If your image already has alpha, you can skip 'remove'
        no_bg_image = remove(input_image)
        
        # 2. TripoSR helper to center and resize object in frame
        # This is critical for good 3D results
        foreground = resize_foreground(no_bg_image, ratio=0.85)
        
        return foreground

    def image_to_mesh(self, image_path, output_path="output/mesh.obj"):
        """
        Generates a 3D mesh (OBJ) from a single image.
        """
        # Prepare image
        processed_image = self.preprocess_image(image_path)
        
        # Run Inference
        print("Running TripoSR inference...")
        with torch.no_grad():
            scene_codes = self.model([processed_image], device=self.device)
            meshes = self.model.extract_mesh(scene_codes)
        
        # Save output
        mesh = meshes[0]
        mesh.export(output_path)
        print(f"Mesh saved to {output_path}")
        
        return mesh, output_path