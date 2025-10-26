FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/usr/games"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fortune-mod \
        cowsay \
        socat \
        bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["bash", "/app/wisecow.sh"]

