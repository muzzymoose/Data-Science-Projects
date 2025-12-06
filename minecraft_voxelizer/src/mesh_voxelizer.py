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
        
        # 1. Normalize Scaling
        # Fit the mesh into a unit cube (1x1x1) so it fits in our grid
        mesh.apply_translation(-mesh.centroid)
        scale = 1.0 / max(mesh.extents)
        mesh.apply_scale(scale)
        
        # 2. Voxelize (Solid)
        # pitch is the edge length of one voxel
        pitch = 1.0 / self.resolution
        voxel_grid = mesh.voxelized(pitch=pitch)
        
        # Fill the inside (so the house isn't hollow)
        voxel_grid = voxel_grid.fill()
        
        # 3. Extract Coordinates & Colors
        # voxel_grid.matrix is a boolean 3D array [64, 64, 64]
        # We need to map this back to colors.
        
        indices = np.argwhere(voxel_grid.matrix)
        final_voxels = {}
        
        # Get colors from the original mesh texture
        # We query the nearest point on the surface for every voxel center
        print("Mapping textures to voxels...")
        
        # Convert grid indices back to spatial coordinates for querying
        # (This math aligns the grid back to the mesh space)
        voxel_centers = voxel_grid.points
        
        # Find nearest point on the original mesh for every voxel center
        closest_points, distances, triangle_id = mesh.nearest.on_surface(voxel_centers)
        
        # If the mesh has a texture image (visual.material)
        if hasattr(mesh.visual, 'material') and mesh.visual.material.image is not None:
            # This is complex UV mapping logic handled by trimesh visual
            # Simplification: use vertex color approximation or ray cast color
            # For TripoSR, it usually exports vertex colors or simple UVs.
            # Let's try to grab face colors.
             pass 
             # (Color mapping is complex in code without visual debug, 
             # usually we fallback to a simple 'average color' or 'nearest vertex color')
             
        # Fallback/Standard: Use nearest vertex color
        # TripoSR meshes usually have vertex colors baked in
        if hasattr(mesh.visual, 'vertex_colors'):
            # visual.vertex_colors is an array of RGBA
            # triangle_id tells us which face is closest.
            # We take the color of the first vertex of that face.
            faces = mesh.faces[triangle_id]
            vertex_indices = faces[:, 0]
            colors = mesh.visual.vertex_colors[vertex_indices]
            
            for i, coord in enumerate(indices):
                # coord is (x,y,z) index
                rgba = colors[i]
                final_voxels[tuple(coord)] = (rgba[0], rgba[1], rgba[2])
        else:
            # If no color found, make it White
            for coord in indices:
                final_voxels[tuple(coord)] = (255, 255, 255)

        return final_voxels