import torch
from transformers import pipeline
from PIL import Image
import numpy as np

class DepthEstimator:
    def __init__(self, model_type="depth-anything/Depth-Anything-V2-Small-hf"):
        """
        Initializes the depth estimation model.
        Options: 
        - "depth-anything/Depth-Anything-V2-Small-hf" (Fast)
        - "depth-anything/Depth-Anything-V2-Large-hf" (High Detail)
        """
        self.device = "cuda" if torch.cuda.is_available() else "cpu"
        print(f"Loading Depth Model on {self.device}...")
        self.pipe = pipeline(task="depth-estimation", model=model_type, device=self.device)

    def predict_depth(self, pil_image):
        """
        Returns normalized depth map (numpy array) where close=255, far=0.
        """
        # Run inference
        output = self.pipe(pil_image)
        depth_map = output["depth"]
        
        # Convert to numpy and normalize 0-1
        depth_np = np.array(depth_map)
        depth_min = depth_np.min()
        depth_max = depth_np.max()
        
        normalized_depth = (depth_np - depth_min) / (depth_max - depth_min)
        
        # Invert if necessary (Depth Anything usually outputs disparity: close=high)
        # We want Z-distance (close=low value, far=high value) for 3D projection
        # But for voxel grid logic, we usually map 0->1.
        
        return normalized_depth