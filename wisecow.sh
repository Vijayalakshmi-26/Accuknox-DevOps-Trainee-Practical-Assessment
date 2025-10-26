#!/usr/bin/env bash

SRVPORT=${SRVPORT:-4499}

prerequisites() {
    # Check commands
    for cmd in cowsay fortune; do
        command -v "$cmd" >/dev/null 2>&1 || {
            echo "Error: $cmd not installed"
            exit 1
        }
    done
}

handleRequest() {
    # Generate HTTP response
    echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n"
    echo -e "<html><head><title>Wisecow Wisdom</title></head><body>"
    echo -e "<h1>Wisecow Says:</h1>"
    echo -e "<pre>$(fortune | cowsay)</pre>"
    echo -e "</body></html>"
}

main() {
    prerequisites
    echo "Wisdom server running on port $SRVPORT..."

    # Use 'socat' instead of nc for reliable TCP serving
    # Install socat in Dockerfile: apt-get install -y socat
    socat TCP-LISTEN:$SRVPORT,reuseaddr,fork EXEC:"bash -c handleRequest"
}

main

