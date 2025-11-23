FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update and install SSH + sudo
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*

# Create SSH runtime directory
RUN mkdir -p /var/run/sshd

# Generate SSH host keys
RUN ssh-keygen -A

# Set root password (for testing only!)
RUN echo 'root:test' | chpasswd

# Allow root login and password authentication
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
