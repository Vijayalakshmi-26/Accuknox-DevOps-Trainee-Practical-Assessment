#!/usr/bin/env python3
import http.server
import socketserver
import subprocess

PORT = 4499

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()

        # Generate cowsay + fortune output
        try:
            output = subprocess.check_output(['bash','-c','fortune | cowsay'], text=True)
        except Exception as e:
            output = f"Error generating wisdom: {e}"

        html = f"""
        <html>
        <head><title>Wisecow Wisdom</title></head>
        <body>
            <h1>Wisecow Says:</h1>
            <pre>{output}</pre>
        </body>
        </html>
        """
        self.wfile.write(html.encode('utf-8'))

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Wisecow serving on port {PORT}")
    httpd.serve_forever()

