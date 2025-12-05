You are an expert in computer vision, 3D reconstruction, voxel modeling, and Minecraft-style block mapping. Your task is to help me build an end-to-end Python-based system that converts any 2D input image into:

1. A 3D voxel representation of the object/building in the image.
2. Three orthographic blueprint views:
   - Top (plan view)
   - Front view
   - Side view
3. A complete materials list summarizing Minecraft block types and counts needed to recreate the structure.

I am working in Python, and I need you to help me design and implement every component of this system. Your responses should be extremely detailed, accurate, practical, and production-ready. The project should be broken into clear modules and steps.

---------------------------------------
### OBJECTIVE
Build a Python pipeline that takes an input image and outputs:
- A voxel grid (e.g., 64×64×64)
- Top view PNG
- Front view PNG
- Side view PNG
- `materials_list.json` (block → count)

---------------------------------------
### SYSTEM REQUIREMENTS
Follow this architecture:

#### 1. Preprocessing
- Load and normalize the input image.
- Optionally crop/resize for model compatibility.

#### 2. Depth Estimation
Use a pretrained model such as:
- MiDaS
- DPT
- Depth Anything V2

Output: depth map aligned with the input image.

#### 3. 3D Reconstruction (Voxel Generation)
Help me select and implement one of these approaches:
- 3D U-Net voxel generator
- 3D CNN depth → voxel approach
- Alternative: Shap-E for neural field → voxelization

Output: a voxel grid with RGB color per voxel or scalar occupancy + color.

#### 4. Voxel → Minecraft Block Mapping
Implement:
- A Minecraft block color reference table (CSV or dictionary).
- Color distance matching (Euclidean or LAB).
- Optional smoothing rules to avoid noisy single-voxel outliers.
- Output a voxel grid containing Minecraft block IDs.

#### 5. Rendering Blueprint Views
Use PyTorch3D, Trimesh, or Open3D to produce orthographic projections:
- Top view
- Front view
- Side view

Views must be clean, pixel-aligned, and optionally include block texture overlays.

#### 6. Materials Summary
- Count each block type in the voxel grid.
- Output JSON and optionally CSV.

---------------------------------------
### WHAT I NEED YOU TO GENERATE
For each major part of the system, provide:

1. **Design explanation**  
   - Options  
   - Tradeoffs  
   - Recommended selection  
   - Assumptions

2. **Python code** (clean, modular, and runnable)  
   Modules should include:  
   - `preprocess.py`  
   - `depth_estimation.py`  
   - `voxel_generator.py`  
   - `block_mapper.py`  
   - `renderer.py`  
   - `materials_summary.py`  
   - `main.py`

3. **Instructions to run the entire pipeline**
   - Required Python packages  
   - Virtual environment setup  
   - How to download pretrained depth models  
   - How to organize project folders  
   - Example CLI commands  

4. **Dataset creation help**
   - How to create synthetic voxel training data  
   - How to render 2D images from voxel builds  
   - How to store paired image/voxel samples  

5. **Error handling, testing examples, and improvement roadmap**
   - Sanity checks  
   - Visualization utilities  
   - Future improvements (GANs, 3D diffusion, NeRF, etc.)

---------------------------------------
### STYLE & FORMAT
- Do NOT give high-level advice only. Provide concrete, real code.
- No pseudocode unless specifically requested.
- Each module must be runnable independently.
- Produce long-form, step-by-step, implementation-level instructions.
- Use Python 3.10+ and PyTorch.
- Assume I want to copy code directly from your response.

---------------------------------------
### START NOW
Begin by proposing the overall system architecture and file structure, then proceed module-by-module. Do not skip steps. Produce all code and explanations in Python.
