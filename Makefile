.PHONY: serve clean

serve:
	@echo "Starting Python HTTP server on localhost:3000..."
	@python3 -m http.server 3000 --bind 127.0.0.1

clean:
	@echo "Cleaning up..."
	@# Add cleanup commands if needed