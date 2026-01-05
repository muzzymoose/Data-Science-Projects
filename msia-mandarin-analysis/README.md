# 🏙️ Malaysian Mandarin NLP: Semantic Mapping of Property Vlogs

This project performs a **linguistic and semantic analysis of Malaysian Mandarin code-switching (Manglish)** within the property development niche. Using a transcript from **Zack's Property Channel**, the pipeline extracts text, cleanses dialect-specific particles, and applies **Word2Vec combined with Principal Component Analysis (PCA)** to visualize semantic relationships between infrastructure terms (e.g. *RTS*, *CIQ*) and sales discourse.

---

## 📌 Project Overview

Malaysian Mandarin is unique due to frequent **code-switching with English** and the use of **local discourse particles** (*lah, leh, mah*).  
This project captures these nuances to analyze how a professional property agent structures their **sales narrative** within a **2D mathematical embedding space**.

---

## 📂 Project Structure
```
msia-mandarin-analysis/
├── assets/
│ ├── msia_dict.txt # Custom dictionary for local terms (RTS, CIQ, etc.)
│ └── stopwords.txt # Filter for high-frequency Mandarin particles
├── data/
│ ├── raw/ # Original and translated JSON transcripts
│ └── processed/ # Clean tokens and PCA export (HTML / PNG)
├── notebooks/
│ ├── 01_extraction.ipynb # YouTube API data pipeline
│ ├── 02_eda_and_cleaning.ipynb # Jieba tokenization & frequency analysis
│ └── 03_pca_clustering.ipynb # Word2Vec + PCA dimensionality reduction
├── src/
│ └── translate_local.py # Offline translation enrichment script
└── .venv/ # Local Python environment
```


---

## 🛠️ Technical Workflow

### 1. Data Extraction & Enrichment

- **API**: Utilized `YouTubeTranscriptApi` to extract both manual and auto-generated Mandarin subtitles.
- **Translation**: Implemented a local translation pipeline using `deep-translator` to build a **parallel bilingual corpus** for cross-linguistic comparison.

---

### 2. Custom NLP Preprocessing

- **Tokenization**:  
  Used `jieba` with a **custom user dictionary** to prevent technical acronyms (e.g. *CIQ*, *RTS*) from being split into individual characters.

- **Stop Word Filtering**:  
  Removed high-frequency discourse fillers (e.g. *這個*, *就是*) to ensure PCA emphasized **topical and semantic variance** rather than grammatical noise.

---

### 3. Word Embeddings & PCA

- **Vectorization**:  
  Trained a `Word2Vec` model (via `gensim`) to represent each token as a **100-dimensional vector** based on contextual usage.

- **Dimensionality Reduction**:  
  Applied **Principal Component Analysis (PCA)** to project embeddings into 2D space.

  - **PC1 (Principal Component 1)**  
    Captures variance between **property technical terminology** and **grammatical particles**.

  - **PC2 (Principal Component 2)**  
    Differentiates **action-oriented verbs** from **static descriptive nouns**.

---

## 📊 Results & Interpretation

The resulting **Interactive Semantic Map** (`zack_pca_map.html`) reveals:

- **Infrastructure Clumping**  
  Terms such as *CIQ*, *RTS*, and *Link Bridge* cluster tightly, indicating the model successfully learned their **shared geographic and economic context**.

- **Code-Switching Islands**  
  English loanwords form distinct clusters, demonstrating that code-switched terms occupy **specialized semantic roles** separate from native Mandarin verbs.

---

## 🎯 Impact

Beyond exploratory analysis, this project evolved into a **Personalized Language Acquisition Tool**.

The pipeline automatically generates a **bilingual study guide** (Mandarin, Pinyin, and English), ranked by **Information Density** (sentence length), enabling efficient learning of **complex, dialect-specific property vocabulary**.

---

## 🚀 How to Run

### Clone the Repository
```bash
git clone https://github.com/muzzymoose/Data-Science-Projects/tree/main/msia-mandarin-analysis

