FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
        openssh-server \
        sudo \
        curl \
        wget \
        git \
        vim \
        net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# یه یوزر با پسورد بساز
RUN useradd -m -s /bin/bash user \
    && echo "user:password123" | chpasswd \
    && usermod -aG sudo user

# SSH config
RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
