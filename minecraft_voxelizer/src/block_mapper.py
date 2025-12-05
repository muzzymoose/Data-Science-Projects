import json
import numpy as np
from scipy.spatial import KDTree

class BlockMapper:
    def __init__(self, palette_path):
        with open(palette_path, 'r') as f:
            self.palette = json.load(f)
        
        self.block_names = list(self.palette.keys())
        self.block_colors = list(self.palette.values())
        
        # Create KDTree for fast color lookup
        self.tree = KDTree(self.block_colors)

    def map_voxels_to_blocks(self, voxel_data):
        """
        Input: dict {(x,y,z): (r,g,b)}
        Output: dict {(x,y,z): "block_name"}
        """
        mapped_voxels = {}
        
        print("Mapping colors to blocks...")
        for coord, rgb in voxel_data.items():
            # Query KDTree
            dist, index = self.tree.query(rgb)
            block_name = self.block_names[index]
            mapped_voxels[coord] = block_name
            
        return mapped_voxels