.PHONY: help textbook clean serve

help:
	@echo "Please use 'make <target>' where <target> is one of:"
	@echo "  textbook    to convert the `notebooks/` folder into Jekyll markdown in `chapters/`"
	@echo "  clean       to clean out site build files"
	@echo "  runall      to run all notebooks in-place, capturing outputs with the notebook"
	@echo "  serve       to serve the repository locally with Jekyll"

textbook:
	python scripts/clean.py

	rm -rf content

	git clone --depth 1 https://github.com/COGS108/tutorials content
	rm content/README.md

	python scripts/generate_book.py

	rm -rf content

runall:
	python scripts/execute_all_notebooks.py

clean:
	python scripts/clean.py

serve:
	bundle exec jekyll serve
