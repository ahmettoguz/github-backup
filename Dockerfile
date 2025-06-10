FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq

WORKDIR /app

COPY . .

ENTRYPOINT ["bash", "/app/run.sh"]