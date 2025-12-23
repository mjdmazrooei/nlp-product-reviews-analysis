SHELL := /bin/bash
PY := python

.PHONY: help data train analyze monitor api test clean

help:
	@echo "Targets:"
	@echo "  make data     - Build dataset (HF download or synthetic fallback)"
	@echo "  make train    - Train sentiment model + save artifacts"
	@echo "  make analyze  - Topics + aspects + evaluation reports"
	@echo "  make monitor  - Drift + sentiment shift monitoring"
	@echo "  make api      - Run FastAPI server"
	@echo "  make test     - Run unit tests"
	@echo "  make clean    - Remove artifacts (processed data, models, reports)"

data:
	$(PY) scripts/build_dataset.py

train:
	$(PY) scripts/train_sentiment.py

analyze:
	$(PY) scripts/topic_model.py
	$(PY) scripts/aspect_mining.py
	$(PY) scripts/evaluate.py

monitor:
	$(PY) scripts/monitor.py

api:
	uvicorn api.app:app --reload --host 127.0.0.1 --port 8000

test:
	pytest -q

clean:
	rm -rf data/processed/* models/* reports/*
	@echo "Cleaned."
