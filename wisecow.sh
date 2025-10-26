from http.server import HTTPServer, BaseHTTPRequestHandler
import subprocess

PORT = 4499

class WisecowHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

        # Get fortune | cowsay output
        cow_output = subprocess.getoutput("fortune | cowsay")
        response = f"""
        <html>
        <head><title>Wisecow Wisdom</title></head>
        <body>
        <h1>Wisecow Says:</h1>
        <pre>{cow_output}</pre>
        </body>
        </html>
        """
        self.wfile.write(response.encode("utf-8"))

httpd = HTTPServer(('', PORT), WisecowHandler)
print(f"Wisdom server running on port {PORT}...")
httpd.serve_forever()

