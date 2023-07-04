FROM golang:alpine AS builder

WORKDIR /go/src
COPY . .
RUN go build -o goapp

# ---------------

FROM alpine
COPY --from=builder /go/src/goapp /app/goapp
ENTRYPOINT [ "/app/goapp" ]


# ENTRYPOINT [ "go", "run", "main.go" ]
# or ENTRYPOINT go run main.go

# CMD go run main.go

# RUN (happen when build)
# ENTRYPOINT (happen when run but can't sh)
# CMD (happen when run but can sh)