import argparse
import os
import trimesh
import numpy as np
# Import your existing module
from src.mesh_generator import MeshGenerator

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--image", type=str, required=True, help="Input image path")
    parser.add_argument("--output", type=str, default="output/model.glb", help="Output GLB path")
    args = parser.parse_args()
    
    os.makedirs(os.path.dirname(args.output), exist_ok=True)

    # 1. Generate the Mesh (OBJ format)
    # We use your existing generator which uses TripoSR
    generator = MeshGenerator()
    temp_obj_path = args.output.replace(".glb", ".obj")
    
    print(f"--- Generating Mesh from {args.image} ---")
    mesh_obj, _ = generator.image_to_mesh(args.image, temp_obj_path)
    
    # 2. Post-Process for ObjToSchematic
    print("--- Converting to GLB for Web Compatibility ---")
    
    # Load the mesh (Force 'mesh' type to avoid Scene objects)
    mesh = trimesh.load(temp_obj_path, force='mesh')
    
    # ROTATION FIX:
    # TripoSR often outputs Z-up coordinates. 
    # Minecraft/GLB usually expects Y-up. 
    # We rotate -90 degrees on X to make it stand upright.
    rot_matrix = trimesh.transformations.rotation_matrix(
        np.radians(-90), [1, 0, 0]
    )
    mesh.apply_transform(rot_matrix)
    
    # 3. Export as GLB
    # GLB packs the color data better for web viewers
    mesh.export(args.output)
    
    print(f"SUCCESS: Created {args.output}")
    print(f"Next Step: Upload this file to https://objtoschematic.com/editor")

if __name__ == "__main__":
    main()