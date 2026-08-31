# Python Analysis

`sla_analysis.py` loads the generated `data/operations_requests.csv`, calculates operational KPIs, compares teams and breach reasons, examines rework, and produces four PNG visualizations.

## Run

```bash
python data/generate_dataset.py
python python/sla_analysis.py
```

The script creates the full 20,000-row dataset locally and writes charts to `visualizations/`.
