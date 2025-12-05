import cv2
import numpy as np
from PIL import Image

class ImagePreprocessor:
    def __init__(self, target_width=512):
        self.target_width = target_width

    def load_and_resize(self, image_path):
        """
        Loads image, maintains aspect ratio, ensures dimensions match encoder requirements.
        """
        img = Image.open(image_path).convert('RGB')
        w, h = img.size
        
        scale = self.target_width / w
        new_w = self.target_width
        new_h = int(h * scale)
        
        # Ensure height is divisible by 14 (common patch size for ViT models)
        new_h = (new_h // 14) * 14
        
        img = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
        return img, np.array(img)