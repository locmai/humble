FROM alpine:20220715

RUN apk add tftp-hpa

CMD [ "in.tftpd", "--foreground", "--secure", "/var/lib/tftpboot" ]
