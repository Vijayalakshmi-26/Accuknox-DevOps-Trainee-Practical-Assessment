FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/usr/games"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fortune-mod \
        cowsay \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY wisecow.py /app/wisecow.py

EXPOSE 4499

CMD ["python3", "/app/wisecow.py"]

