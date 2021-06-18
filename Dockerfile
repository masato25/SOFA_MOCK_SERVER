FROM golang:1.16.4-alpine3.13

RUN mkdir -p /root/build
COPY . /root/build
WORKDIR /root/build
RUN go mod vendor
RUN apk add gcc musl-dev
RUN go build -o cybavo_mock

FROM alpine:3.13
WORKDIR /root/
COPY --from=0 /root/build/cybavo_mock .
CMD ["./cybavo_mock"]
