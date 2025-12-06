import trimesh
import numpy as np

class MeshVoxelizer:
    def __init__(self, resolution=64):
        self.resolution = resolution

    def voxelize_mesh(self, mesh_path):
            """
            Loads an OBJ/GLB and converts it to a solid Minecraft voxel grid.
            """
            print(f"Voxelizing mesh {mesh_path}...")
            
            # Load the mesh
            mesh = trimesh.load(mesh_path, force='mesh')
            
            # 1. Normalize Scaling (Fit to 1x1x1 box)
            mesh.apply_translation(-mesh.centroid)
            scale = 1.0 / max(mesh.extents)
            mesh.apply_scale(scale)
            
            # 2. Voxelize (Solid)
            pitch = 1.0 / self.resolution
            voxel_grid = mesh.voxelized(pitch=pitch)
            voxel_grid = voxel_grid.fill()
            
            # 3. Extract Coordinates
            indices = np.argwhere(voxel_grid.matrix)
            voxel_centers = voxel_grid.points
            final_voxels = {}
            
            print("Mapping textures to voxels (using KDTree)...")
            
            # --- FIX START: Use Scipy KDTree instead of rtree ---
            from scipy.spatial import KDTree
            
            # Create a tree of the mesh vertices
            tree = KDTree(mesh.vertices)
            
            # Find the nearest mesh vertex for every voxel center
            distances, vertex_indices = tree.query(voxel_centers)
            
            # Get colors from those vertices
            if hasattr(mesh.visual, 'vertex_colors') and len(mesh.visual.vertex_colors) > 0:
                # Trimesh stores colors as RGBA (0-255)
                # We map the vertex index to its color
                colors = mesh.visual.vertex_colors[vertex_indices]
                
                for i, coord in enumerate(indices):
                    # Take RGB, ignore Alpha
                    c = colors[i]
                    final_voxels[tuple(coord)] = (c[0], c[1], c[2])
            else:
                # Fallback to white if no colors found
                print("Warning: No vertex colors found. Defaulting to white.")
                for coord in indices:
                    final_voxels[tuple(coord)] = (255, 255, 255)
            # --- FIX END ---

            return final_voxels