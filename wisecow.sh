#!/usr/bin/env bash

# Set the server port
SRVPORT=${SRVPORT:-4499}

prerequisites() {
    # Check if necessary commands are available
    command -v cowsay >/dev/null 2>&1 &&
    command -v fortune >/dev/null 2>&1 &&
    command -v nc >/dev/null 2>&1 ||
        {
            echo "Error: Missing prerequisites (cowsay, fortune, or netcat)."
            exit 1
        }
}

handleRequest() {
    # Generate the full HTTP response dynamically
    
    # 1. Output HTTP headers
    echo -e "HTTP/1.1 200 OK\r\nConnection: close\r\nContent-Type: text/html\r\n\r\n"
    
    # 2. Output HTML body with cow wisdom
    echo -e "<html><head><title>Wisecow Wisdom</title></head><body>"
    echo -e "<h1>Wisecow Says:</h1>"
    
    # Use <pre> tags to preserve the ASCII art formatting from cowsay
    echo -e "<pre>"
    fortune | cowsay
    echo -e "</pre>"
    
    echo -e "</body></html>"
}

main() {
    prerequisites
    
    echo "Wisdom served continuously on port=$SRVPORT..."

    # CRITICAL FIX: Use an infinite loop to keep netcat listening
    while true; do
        # We pipe the output of handleRequest (the HTTP response) into netcat.
        # nc -l -p $SRVPORT: Listen on port.
        # -q 1: Shut down 1 second after EOF, which forces the loop to restart immediately.
       	handleRequest | nc -l -p $SRVPORT -q 1 -s 0.0.0.0

        
        # NOTE: A short sleep can be added here if needed, but often isn't necessary
        # sleep 0.01 
    done
}

main
