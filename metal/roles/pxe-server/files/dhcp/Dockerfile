FROM alpine:20220328

RUN apk add dhcp

RUN touch /var/lib/dhcp/dhcpd.leases

CMD [ "dhcpd", "-f", "-cf", "/etc/dhcp/dhcpd.conf" ]
