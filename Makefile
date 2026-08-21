.PHONY: setup format lint

setup:
	pip install -r requirements.txt
	pip install ruff pre-commit
	pre-commit install

format:
	ruff format .
	ruff check --fix .

lint:
	ruff check .
	ruff format --check .
