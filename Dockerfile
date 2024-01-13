FROM golang:1.20 AS builder

WORKDIR /src

ADD . .
ARG VERSION
RUN \
  --mount=type=cache,target=/go/pkg/mod \
  --mount=type=cache,target=/root/.cache/go-build \
  CGO_ENABLED=0 \
  GOOS=linux \
  go build \
  -ldflags="-X main.Version=$VERSION" \
  -o /protoc-gen-go-sugar .

FROM scratch
LABEL org.opencontainers.image.source = "https://github.com/pentops/protoc-gen-go-sugar"
COPY --from=builder /protoc-gen-go-sugar /
ENTRYPOINT ["/protoc-gen-go-sugar"]

