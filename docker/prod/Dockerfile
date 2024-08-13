FROM golang:1.23

ARG SERVICE

RUN mkdir /internal
COPY . /internal
WORKDIR /internal/$SERVICE
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /bin/app .

FROM alpine:latest
RUN addgroup -S app && adduser -S app -G app
USER app
WORKDIR /home/app
COPY --from=build-go /bin/app ./
ENTRYPOINT ["./app"]
