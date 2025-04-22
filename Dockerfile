FROM golang:1.24-bullseye AS builder

RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid 65532 \
  small-user

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

COPY .env .env

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o /app/main .

FROM scratch

COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

COPY --from=builder /app/main /main

COPY .env .env

USER small-user:small-user

# Optional: healthcheck
# HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
#   CMD wget --spider --quiet http://localhost:8080/health || exit 1

CMD ["./main"]
