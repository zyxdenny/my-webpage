index.html: main.js
	@echo "Ensure index.html exists or update its rule if dynamic."

main.js: src/*
	elm make src/Main.elm --optimize --output=main.js

