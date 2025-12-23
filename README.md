# NLP Product Reviews Analysis 

A portfolio-grade project that turns raw product reviews into **actionable insights**:
- **Sentiment classification** (TF-IDF + Logistic Regression, calibrated probabilities)
- **Topic discovery** (NMF topic modeling + keyword labels)
- **Aspect mining** (noun-phrase extraction + aspect-level sentiment aggregation)
- **Evaluation** (F1, ROC-AUC, PR-AUC, calibration)
- **Monitoring** (drift detection via PSI/KS + sentiment rate shift)
- **API deployment** (FastAPI) + Docker + CI tests

**Dataset**: by default it downloads a public dataset from Hugging Face (`amazon_polarity`), but if download fails (offline), it will generate a **synthetic** dataset with realistic review patterns so the pipeline still runs end-to-end.

---

## Quickstart

### 1) Setup
```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### 2) Build dataset
```bash
make data
```

### 3) Train sentiment model
```bash
make train
```

### 4) Topics + aspects + evaluation reports
```bash
make analyze
```

### 5) Monitoring report
```bash
make monitor
```

### 6) Run API
```bash
make api
# open http://127.0.0.1:8000/docs
```

---



## Repo Structure
```
.
├── api/                         # FastAPI inference service
├── data/
│   ├── raw/                     # downloaded or generated raw reviews
│   └── processed/               # cleaned dataset + train/test splits
├── models/                      # versioned artifacts (vectorizer, model, metadata)
├── reports/                     # evaluation, topics, aspects, monitoring
├── schemas/                     # data contract for input review records
├── src/reviewnlp/
│   ├── config.py
│   ├── data.py                  # dataset fetch + synthetic fallback
│   ├── preprocess.py            # text cleaning + category heuristics
│   ├── modeling.py              # training + registry
│   ├── topics.py                # NMF topic modeling
│   ├── aspects.py               # noun-phrase mining + aspect sentiment
│   ├── metrics.py
│   └── monitoring.py
├── scripts/                     # CLI entrypoints
├── tests/
├── Dockerfile
├── docker-compose.yml
└── Makefile
```

---

## Outputs
After running `make analyze`, you'll get:
- `reports/eval_metrics.json`
- `reports/topics.json` (topic keywords + example reviews)
- `reports/aspects.json` (top aspects by category with sentiment)
- `reports/sample_predictions.csv`

After `make monitor`:
- `reports/drift_report.json`
- `reports/sentiment_shift.json`

---

## License
MIT
