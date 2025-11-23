FROM codercom/code-server:latest

USER root

RUN apt update
RUN apt install -y ca-certificates curl gnupg lsb-release apt-transport-https

# NodeSource setup
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" \
    > /etc/apt/sources.list.d/nodesource.list
RUN apt update && apt install -y nodejs

# PHP setup
RUN curl -fsSL https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/sury.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/sury-php.list
RUN apt update && apt install -y php7.4 php8.4

# Switch back to normal user
USER coder

EXPOSE 8080
EXPOSE 80
EXPOSE 443

# Don’t override the default ENTRYPOINT or CMD
