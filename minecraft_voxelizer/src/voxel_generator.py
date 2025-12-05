import numpy as np

class VoxelGenerator:
    def __init__(self, grid_size=64):
        self.grid_size = grid_size

    def generate_voxels(self, rgb_array, depth_map):
        """
        Converts RGB image + Depth Map into a Voxel Grid.
        output: dict {(x,y,z): (r,g,b)}
        """
        h, w, _ = rgb_array.shape
        
        # 1. Create a coordinate grid
        # We assume a simplistic orthographic projection for Minecraft style
        # x corresponds to image columns, y to image rows, z to depth
        
        # Downsample factor to hit target voxel grid size roughly
        scale_x = self.grid_size / w
        scale_y = self.grid_size / h
        
        voxel_data = {} # Format: (x, y, z) -> (r, g, b)

        # Iterate over pixels (optimization: this can be vectorized, but loops are clearer for logic)
        # For production, we would use numpy masking.
        
        print("Voxelizing point cloud...")
        
        # Threshold to ignore sky/background (assuming far depth is near 0 or 1 depending on model)
        # Depth Anything: High value = Close. Low value = Far.
        background_threshold = 0.1 

        for y in range(h):
            for x in range(w):
                d_val = depth_map[y, x]
                
                if d_val < background_threshold:
                    continue # Skip background
                
                # Normalize coordinates to grid
                vx = int(x * scale_x)
                # Invert Y because images are top-left origin, 3D is usually bottom-left origin
                vy = int((h - y) * scale_y) 
                
                # Map Depth (0-1) to Z grid (0-64)
                # We squeeze depth to give it volume
                vz = int(d_val * self.grid_size * 0.5) 
                
                color = tuple(rgb_array[y, x])
                
                # Occupancy logic: Only keep the surface or fill?
                # For Minecraft, we usually want a hollow shell or solid. 
                # Let's write the surface voxel.
                if 0 <= vx < self.grid_size and 0 <= vy < self.grid_size:
                    voxel_data[(vx, vy, vz)] = color

        return voxel_data

    def fill_internal_voxels(self, voxel_data):
        """
        Optional: Post-processing to fill gaps between front and back if needed.
        (Skipped for V1 basic shell).
        """
        pass