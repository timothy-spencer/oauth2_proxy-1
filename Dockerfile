FROM golang:1.11-stretch AS builder

# Download tools
RUN wget -O $GOPATH/bin/dep https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64
RUN chmod +x $GOPATH/bin/dep

# Copy sources
WORKDIR $GOPATH/src/github.com/timothy-spencer/oauth2_proxy-1
COPY . .

# Fetch dependencies
RUN dep ensure --vendor-only

# Build binary
RUN ./configure && make build && touch jwt_signing_key.pem

# Copy binary to alpine
FROM alpine:3.8
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/src/github.com/timothy-spencer/oauth2_proxy-1/oauth2_proxy /bin/oauth2_proxy
COPY --from=builder /go/src/github.com/timothy-spencer/oauth2_proxy-1/jwt_signing_key.pem /etc/ssl/certs/jwt_signing_key.pem

ENTRYPOINT ["/bin/oauth2_proxy"]
