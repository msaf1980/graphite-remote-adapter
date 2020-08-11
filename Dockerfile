FROM golang:1.13 as builder

RUN mkdir -p $GOPATH/src/github.com/criteo
WORKDIR $GOPATH/src/github.com/criteo/graphite-remote-adapter
COPY . .
RUN make build


FROM alpine
COPY --from=builder /go/src/github.com/criteo/graphite-remote-adapter/graphite-remote-adapter /bin/.
EXPOSE 9201
ENTRYPOINT graphite-remote-adapter --config.file=/adapter/config.yaml