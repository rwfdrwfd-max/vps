#!/bin/bash

echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

echo "=================================="
echo "SSH Server Starting..."
echo "User     : ${SSH_USER}"
echo "Password : ${SSH_PASSWORD}"
echo "Port     : 12345"
echo "=================================="

exec /usr/sbin/sshd -D -e -p 12345
