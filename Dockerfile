FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update and install SSH + sudo
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
RUN rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
RUN curl -fsSL https://code-server.dev/install.sh | sh

EXPOSE 8080

CMD ["/bin/bash", "code-server"]
