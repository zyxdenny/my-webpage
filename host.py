import http.server
import socketserver
import os

# Configuration
PORT = 8000  # Port to serve the application on
DIRECTORY = "."  # Root directory of the project

class SPAHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def translate_path(self, path):
        # Map the requested path to the file system
        filepath = super().translate_path(path)
        if os.path.isdir(filepath):
            filepath = os.path.join(filepath, "index.html")
        return filepath

    def do_GET(self):
        # Check if the requested file exists
        requested_file = self.translate_path(self.path)
        if not os.path.exists(requested_file):
            # Serve index.html if the file doesn't exist
            self.path = "/index.html"
        return super().do_GET()

def run_server():
    with socketserver.TCPServer(("", PORT), SPAHandler) as httpd:
        print(f"Serving SPA on http://localhost:{PORT}")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down server...")
            httpd.shutdown()

if __name__ == "__main__":
    run_server()

