🏙️ Malaysian Mandarin NLP: Semantic Mapping of Property Vlogs
This project performs a linguistic and semantic analysis of Malaysian Mandarin code-switching (Manglish) within the property development niche. Using a transcript from Zack's Property Channel, the pipeline extracts text, cleanses dialect-specific particles, and uses Word2Vec combined with Principal Component Analysis (PCA) to visualize the semantic relationship between infrastructure terms (RTS, CIQ) and sales discourse.

📌 Project Overview
Malaysian Mandarin is unique due to frequent code-switching with English and the use of local particles (lah, leh, mah). This project captures these nuances to see how a professional property agent structures their "sales pitch" in a 2D mathematical space.

📂 Project Structure
msia-mandarin-analysis/
├── assets/
│   ├── msia_dict.txt        # Custom dictionary for local terms (RTS, CIQ, etc.)
│   └── stopwords.txt       # Filter for high-frequency Mandarin particles
├── data/
│   ├── raw/                # Original and Translated JSON transcripts
│   └── processed/          # Clean tokens and PCA export (HTML/PNG)
├── notebooks/
│   ├── 01_extraction.ipynb  # YouTube API Data Pipeline
│   ├── 02_eda_and_cleaning.ipynb # Jieba Tokenization & Frequency Analysis
│   └── 03_pca_clustering.ipynb   # Word2Vec + PCA Dimensionality Reduction
├── src/
│   └── translate_local.py   # Offline translation enrichment script
└── .venv/                   # Local Python environment

🛠️ Technical Workflow
1. Data Extraction & Enrichment
API: Utilized YouTubeTranscriptApi to pull manual and auto-generated Mandarin subtitles.

Translation: Implemented a local translation script using deep-translator to create a parallel corpus for cross-linguistic comparison.

2. Custom NLP Preprocessing
Tokenization: Used jieba with a custom user dictionary. This was critical to prevent the tokenizer from splitting technical acronyms like CIQ or RTS into individual letters.

Stop Word Filtering: Removed high-frequency "noise" words (這個, 就是) to ensure the PCA focused on topical variance.

3. Word Embeddings & PCA
Vectorization: Trained a Word2Vec model (gensim) to represent each word as a 100-dimensional vector based on its context in the transcript.

Dimensionality Reduction: Applied PCA to reduce the 100D space into 2D.

PC1 (Principal Component 1): Typically captures the variance between "Property Technical Terms" and "Grammatical Particles."

PC2 (Principal Component 2): Identifies the intensity of "Action Verbs" vs. "Static Nouns."

📊 Results & Interpretation
The resulting Interactive Semantic Map (zack_pca_map.html) reveals:

Infrastructure Clumping: Terms like CIQ, RTS, and Link Bridge cluster tightly, proving the model learned their geographic and economic relationship.

Code-Switching Islands: English loanwords often form distinct "islands" in the PCA plot, showing they occupy specific semantic roles distinct from native Mandarin verbs.

🚀 How to Run
Clone the repo:
```
Bash
git clone https://github.com/your-username/msia-mandarin-analysis.git
```

Install Dependencies:
```
Bash
pip install -r requirements.txt
```
Run Notebooks: Start with 01_extraction.ipynb and follow the sequence to generate the final PCA map.