FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
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
        wetty \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash iraj \
    && usermod -aG sudo iraj \
    && echo "iraj ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 3000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
