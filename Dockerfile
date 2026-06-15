FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV SSH_USER=iraj
ENV SSH_PASSWORD=Venw84420

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    git \
    vim \
    net-tools \
    iproute2 \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ${SSH_USER} \
 && echo "${SSH_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /var/run/sshd

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
 && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
 && echo "PermitRootLogin no" >> /etc/ssh/sshd_config \
 && echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 12345

CMD ["/entrypoint.sh"]
