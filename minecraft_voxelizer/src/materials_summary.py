import json
import collections

class MaterialCounter:
    def generate_report(self, mapped_voxels, output_path):
        counter = collections.Counter(mapped_voxels.values())
        
        report = {
            "total_blocks": len(mapped_voxels),
            "materials": dict(counter)
        }
        
        with open(output_path, 'w') as f:
            json.dump(report, f, indent=4)
        
        print(f"Materials list saved to {output_path}")
        return report