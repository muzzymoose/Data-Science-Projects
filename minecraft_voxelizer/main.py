import argparse
import os
from src.mesh_generator import MeshGenerator
from src.mesh_voxelizer import MeshVoxelizer
from src.renderer import Open3DRenderer
from src.block_mapper import BlockMapper
from src.materials_summary import MaterialCounter

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--image", type=str, required=True)
    parser.add_argument("--grid", type=int, default=64)
    args = parser.parse_args()
    
    os.makedirs("output", exist_ok=True)

    # 1. Generate True 3D Mesh
    generator = MeshGenerator()
    # This creates 'output/mesh.obj'
    mesh_obj, mesh_path = generator.image_to_mesh(args.image, "output/mesh.obj")
    
    # 2. Voxelize the Mesh
    voxelizer = MeshVoxelizer(resolution=args.grid)
    voxel_data = voxelizer.voxelize_mesh(mesh_path)
    
    # 3. Map to Minecraft Blocks
    mapper = BlockMapper("assets/block_colors.json")
    final_blocks = mapper.map_voxels_to_blocks(voxel_data)
    
    # 4. Render Blueprints
    renderer = Open3DRenderer("output")
    o3d_grid = renderer.voxel_dict_to_geometry(voxel_data)
    renderer.render_blueprints(o3d_grid)
    
    # 5. Material List
    counter = MaterialCounter()
    counter.generate_report(final_blocks, "output/materials.json")
    
    print("Done! Check output/ folder.")

if __name__ == "__main__":
    main()