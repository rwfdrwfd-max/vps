#!/bin/bash

# set password
echo "iraj:${SSH_PASSWORD}" | chpasswd

# print info
echo "=============================="
echo "  SSH Server Starting..."
echo "=============================="
echo "  User     : iraj"
echo "  Password : ${SSH_PASSWORD}"
echo ""
echo "  Local IP : $(hostname -I | awk '{print $1}')"
echo "=============================="
echo "  Web Terminal : port 3000"
echo "  SSH          : port 22"
echo "=============================="

# start ssh
service ssh start

# start wetty (web terminal)
wetty --port 3000 --base / --ssh-host localhost --ssh-port 22 --ssh-user iraj &

echo ""
echo "  Ready! Open browser for web terminal."
echo "=============================="

# keep container alive
wait
