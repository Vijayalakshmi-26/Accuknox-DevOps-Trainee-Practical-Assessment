# Suggested Dockerfile
FROM ubuntu:latest
LABEL maintainer="vijayalakshmi26"

# 1. Install prerequisites (netcat, cowsay, fortune)
RUN apt-get update && \
    apt-get install -y netcat-openbsd cowsay fortune && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 2. Copy the script
COPY wisecow.sh /usr/local/bin/wisecow.sh
RUN chmod +x /usr/local/bin/wisecow.sh

# 3. Set the application port
ENV SRVPORT=4499
EXPOSE 4499

# 4. Set the entrypoint to run the script
# Use exec form to ensure proper signal handling
CMD ["/usr/local/bin/wisecow.sh"]
