# Use a lightweight Debian image
FROM debian:stable-slim

# Set noninteractive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fortune-mod \
        fortunes \
        cowsay \
        netcat-openbsd \
        bash && \
    # Link fortune and cowsay to /usr/bin
    ln -s /usr/games/fortune /usr/bin/fortune && \
    ln -s /usr/games/cowsay /usr/bin/cowsay && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy wisecow script
COPY wisecow.sh /app/wisecow.sh

# Make script executable
RUN chmod +x /app/wisecow.sh

# Expose the port
EXPOSE 4499

# Run the script
CMD ["/app/wisecow.sh"]
