import os
import argparse
import matplotlib.pyplot as plt
from src.preprocess import ImagePreprocessor
from src.depth_estimation import DepthEstimator
from src.voxel_generator import VoxelGenerator
from src.block_mapper import BlockMapper
from src.materials_summary import MaterialCounter

def main():
    parser = argparse.ArgumentParser(description="Image to Minecraft Voxelizer")
    parser.add_argument("--image", type=str, required=True, help="Path to input image")
    parser.add_argument("--output", type=str, default="output", help="Output folder")
    parser.add_argument("--grid", type=int, default=64, help="Voxel grid size")
    args = parser.parse_args()

    os.makedirs(args.output, exist_ok=True)

    # 1. Preprocess
    print("--- Step 1: Preprocessing ---")
    preprocessor = ImagePreprocessor()
    pil_img, np_img = preprocessor.load_and_resize(args.image)

    # 2. Depth Estimation
    print("--- Step 2: Depth Estimation ---")
    depth_est = DepthEstimator()
    depth_map = depth_est.predict_depth(pil_img)
    
    # Debug: Save depth map
    plt.imsave(os.path.join(args.output, "debug_depth.png"), depth_map, cmap='inferno')

    # 3. Voxel Generation
    print("--- Step 3: Voxel Generation ---")
    vox_gen = VoxelGenerator(grid_size=args.grid)
    raw_voxels = vox_gen.generate_voxels(np_img, depth_map)

    # 4. Block Mapping
    print("--- Step 4: Block Mapping ---")
    mapper = BlockMapper("assets/block_colors.json")
    final_blocks = mapper.map_voxels_to_blocks(raw_voxels)

    # 5. Materials List
    print("--- Step 5: Materials Summary ---")
    counter = MaterialCounter()
    counter.generate_report(final_blocks, os.path.join(args.output, "materials.json"))

    print("--- Pipeline Complete ---")
    print(f"Generated {len(final_blocks)} blocks.")

if __name__ == "__main__":
    main()