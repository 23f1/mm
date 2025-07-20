import json

def flatten_json(obj, prefix=''):
    """
    Recursively flattens JSON object using dot notation.
    Handles nested dicts and lists.
    """
    items = {}
    if isinstance(obj, dict):
        for k, v in obj.items():
            new_key = f"{prefix}.{k}" if prefix else k
            items.update(flatten_json(v, new_key))
    elif isinstance(obj, list):
        for i, v in enumerate(obj):
            new_key = f"{prefix}.{i}" if prefix else str(i)
            items.update(flatten_json(v, new_key))
    else:
        items[prefix] = obj
    return items

def compare_json_files(file_a, file_b):
    with open(file_a, 'r') as fa, open(file_b, 'r') as fb:
        json_a = json.load(fa)
        json_b = json.load(fb)

    flat_a = flatten_json(json_a)
    flat_b = flatten_json(json_b)

    all_keys = set(flat_a.keys()).union(set(flat_b.keys()))

    for key in sorted(all_keys):
        val_a = flat_a.get(key, '_MISSING_')
        val_b = flat_b.get(key, '_MISSING_')
        if val_a != val_b:
            print(key)

# Example usage:
# Place a.json and b.json in the same directory and run:
compare_json_files('a.json', 'b.json')





