cat > /etc/netplan/00-installer-config.yaml <<EOF
network:
  wifis:
    wlp1s0:
      optional: true
      dhcp4: false
      addresses: [192.168.1.68/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8]
      access-points:
        "<access-points name>":
          password: "<password>"
  ethernets:
    eno1:
      optional: true
      dhcp4: false
      addresses:
        - 192.168.1.52/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
        - 8.8.8.8
  version: 2
EOF