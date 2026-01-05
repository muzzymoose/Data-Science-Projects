import json
import os
from deep_translator import GoogleTranslator

# This gets the directory where translate_local.py is located (src/)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Move up one level and then into data/raw/
INPUT_PATH = os.path.join(BASE_DIR, '..', 'data', 'raw', 'z_channel_apartment.json')
OUTPUT_PATH = os.path.join(BASE_DIR, '..', 'data', 'raw', 'z_channel_apartment_en.json')

def translate_local_json():
    print(f"Checking path: {os.path.abspath(INPUT_PATH)}") # Debugging line
    
    if not os.path.exists(INPUT_PATH):
        print(f"❌ Mandarin JSON not found at {os.path.abspath(INPUT_PATH)}!")
        return

    with open(INPUT_PATH, 'r', encoding='utf-8') as f:
        data = json.load(f)

    translator = GoogleTranslator(source='zh-TW', target='en')
    
    print(f"Translating {len(data)} lines... please wait.")
    
    translated_data = []
    for entry in data:
        try:
            # We translate the text field of each entry
            translated_text = translator.translate(entry['text'])
            translated_data.append({
                'text': translated_text,
                'start': entry['start'],
                'duration': entry['duration'],
                'original_text': entry['text'] # Keep both for comparison!
            })
        except Exception as e:
            print(f"Skipping a line due to error: {e}")

    with open(OUTPUT_PATH, 'w', encoding='utf-8') as f:
        json.dump(translated_data, f, ensure_ascii=False, indent=4)

    print(f"✅ Successfully translated and saved to {OUTPUT_PATH}")

if __name__ == "__main__":
    translate_local_json()