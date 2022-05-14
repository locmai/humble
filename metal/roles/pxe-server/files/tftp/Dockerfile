FROM alpine:20220328

RUN apk add tftp-hpa

CMD [ "in.tftpd", "--foreground", "--secure", "/var/lib/tftpboot" ]
