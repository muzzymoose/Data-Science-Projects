import open3d as o3d
import numpy as np
import os

class Open3DRenderer:
    def __init__(self, output_folder="output"):
        self.output_folder = output_folder
        os.makedirs(self.output_folder, exist_ok=True)

    def voxel_dict_to_geometry(self, voxel_data, voxel_size=1.0):
        """
        Converts dictionary {(x,y,z): (r,g,b)} to Open3D VoxelGrid.
        """
        print("Converting voxel dictionary to Open3D geometry...")
        
        # 1. Extract points and colors from dict
        points = []
        colors = []
        
        for coord, color in voxel_data.items():
            points.append(list(coord))
            # Open3D expects RGB in [0, 1] range
            colors.append([c / 255.0 for c in color])
            
        if not points:
            print("Warning: No voxels to render.")
            return None

        # 2. Create PointCloud first (intermediate step)
        pcd = o3d.geometry.PointCloud()
        pcd.points = o3d.utility.Vector3dVector(np.array(points))
        pcd.colors = o3d.utility.Vector3dVector(np.array(colors))
        
        # 3. Create VoxelGrid from PointCloud
        # We use the exact voxel_size to match our grid logic
        voxel_grid = o3d.geometry.VoxelGrid.create_from_point_cloud(
            pcd, 
            voxel_size=voxel_size
        )
        
        return voxel_grid

    def render_blueprints(self, voxel_grid):
        """
        Generates Top, Front, and Side views and saves them as PNGs.
        """
        if voxel_grid is None:
            return

        print("Rendering blueprint views...")
        
        # Setup the visualizer
        vis = o3d.visualization.Visualizer()
        # Create window (visible=False tries to run headless, but may pop up briefly on some OS)
        vis.create_window(visible=False, width=1024, height=1024)
        vis.add_geometry(voxel_grid)
        
        # Set white background for blueprints
        opt = vis.get_render_option()
        opt.background_color = np.asarray([1, 1, 1])
        opt.show_coordinate_frame = False
        
        # Get the view control to rotate the camera
        ctr = vis.get_view_control()
        
        # --- VIEW 1: FRONT VIEW ---
        # Look at the center, from the front (+Z)
        # Note: Open3D coordinates might need tweaking based on your data orientation
        print("Rendering Front View...")
        ctr.set_front([0, 0, -1])  # Look along -Z
        ctr.set_lookat([32, 32, 32]) # Approximate center of 64x64x64 grid
        ctr.set_up([0, 1, 0])      # Y is up
        ctr.set_zoom(0.8)
        vis.poll_events()
        vis.update_renderer()
        vis.capture_screen_image(os.path.join(self.output_folder, "view_front.png"))

        # --- VIEW 2: SIDE VIEW ---
        print("Rendering Side View...")
        ctr.set_front([-1, 0, 0])  # Look along -X
        ctr.set_lookat([32, 32, 32])
        ctr.set_up([0, 1, 0])
        vis.poll_events()
        vis.update_renderer()
        vis.capture_screen_image(os.path.join(self.output_folder, "view_side.png"))

        # --- VIEW 3: TOP VIEW ---
        print("Rendering Top View...")
        ctr.set_front([0, -1, 0])  # Look along -Y
        ctr.set_lookat([32, 32, 32])
        ctr.set_up([0, 0, -1])     # Z is up relative to screen
        vis.poll_events()
        vis.update_renderer()
        vis.capture_screen_image(os.path.join(self.output_folder, "view_top.png"))

        vis.destroy_window()
        print("Blueprints saved.")

    def show_interactive(self, voxel_grid):
        """
        Launches an interactive window to rotate/inspect the model.
        """
        print("Launching interactive viewer...")
        o3d.visualization.draw_geometries([voxel_grid], window_name="Minecraft Voxel Preview")