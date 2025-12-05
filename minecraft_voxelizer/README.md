# Minecraft Blueprint Generator

Convert any 2D image into a 3D Minecraft-style voxel structure with automatically generated blueprint views (top, front, side) and a complete materials list of required blocks.

## 📌 Overview

**Minecraft Blueprint Generator** is a Python-based computer vision and 3D reconstruction pipeline designed to translate real-world or digital images into Minecraft-ready voxel structures. The system outputs:

* **3D voxel grid** approximating the structure in the input image
* **Top (plan), front, and side blueprint views**
* **Minecraft materials list** with block counts

This project does **not** require any Minecraft modding or world injection — outputs are purely blueprint and voxel data.

---

## 🚀 Features

* **Image preprocessing** to standardize input
* **Depth estimation** using pretrained CV models (MiDaS / DPT / Depth Anything)
* **3D voxel reconstruction** using a voxel generation model
* **Color-to-block mapping** based on Minecraft block color references
* **3-view rendering** using orthographic projections
* **Material summary generation** in JSON/CSV format

---

## 📁 Project Structure

```
minecraft-blueprint-generator/
├── preprocess.py
├── depth_estimation.py
├── voxel_generator.py
├── block_mapper.py
├── renderer.py
├── materials_summary.py
├── main.py
├── data/
│   ├── block_colors.csv
│   └── samples/
└── outputs/
    ├── voxel_grid.npy
    ├── top_view.png
    ├── front_view.png
    ├── side_view.png
    └── materials.json
```

---

## 🛠️ Installation

### 1. Clone the repository

```
git clone https://github.com/yourusername/minecraft-blueprint-generator.git
cd minecraft-blueprint-generator
```

### 2. Create a virtual environment

```
python -m venv venv
source venv/bin/activate   # Linux/Mac
venv\Scripts\activate      # Windows
```

### 3. Install dependencies

```
pip install -r requirements.txt
```

---

## 📥 Input Requirements

The system accepts:

* Any JPG/PNG image
* Recommended resolution: 256×256–512×512
* Should contain a single main object for best reconstruction quality

---

## 🧠 How It Works

### 1. **Preprocessing**

Images are normalized, resized, and prepared for depth estimation.

### 2. **Depth Estimation**

A pretrained neural network infers pixel-wise depth from the image.

### 3. **Voxel Generation**

The depth map is converted into a 3D voxel structure via:

* 3D CNN or
* UNet-based voxel generator or
* Shap-E neural field voxelization

### 4. **Block Mapping**

Voxel colors → closest Minecraft block type using a color distance lookup.

### 5. **Rendering Views**

The voxel structure is converted into top, front, and side orthographic blueprint images.

### 6. **Materials Summary**

All blocks in the voxel grid are counted and exported to JSON.

---

## ▶️ Usage

Run the full pipeline:

```
python main.py --input image.jpg
```

Outputs will be saved in the `outputs/` folder.

---

## 📊 Outputs

After running the pipeline, you will get:

* `top_view.png`
* `front_view.png`
* `side_view.png`
* `materials.json`
* `voxel_grid.npy`

Example materials output:

```json
{
  "oak_planks": 1240,
  "stone": 532,
  "glass": 48,
  "cobblestone": 310
}
```

---

## 📚 Training Data (Optional)

If you plan to train your own voxel generator, you may need:

* Synthetic voxel builds
* Rendered images of those builds
* Block color references

Instructions for dataset preparation are included in the docs.

---

## 🧩 Future Improvements

* Support for text + image conditioning
* Higher-resolution voxel grids
* Real Minecraft texture overlays for blueprint views
* Web-based interface (Gradio/Streamlit)
* 3D diffusion model reconstruction

---

## 🤝 Contributing

Pull requests are welcome. For major changes, open an issue first to discuss your ideas.

---

## 📄 License

MIT License.

---

## ⭐ Acknowledgements

This project integrates:

* PyTorch3D
* MiDaS / DPT depth models
* Minecraft open-source block color databases

Happy building! 🧱✨
