FROM golang:1.19-alpine3.16 as build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o /vault-init-tool

FROM golang:1.19-alpine3.16 as bin

WORKDIR /

COPY --from=build /vault-init-tool /vault-init-tool

ENTRYPOINT ["/vault-init-tool"]
