FROM golang:1.22.5 AS base

WORKDIR /myapp

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main .

# Final stage - Distroless image
FROM gcr.io/distroless/base

WORKDIR /

COPY --from=base /myapp/main .
COPY --from=base /myapp/static ./static

EXPOSE 8080

CMD ["./main"]