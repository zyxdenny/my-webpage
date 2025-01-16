index.html: main.js
	@echo "Ensure index.html exists or update its rule if dynamic."

main.js: src/Main.elm
	elm make src/Main.elm --optimize --output=main.js

