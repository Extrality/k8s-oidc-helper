FROM golang:1.17-alpine AS build
WORKDIR /build
COPY . .
RUN apk --no-cache add git \
 && go get ./... \
 && CGO_ENABLED=0 go build -o /kubernetes-auth-conf .

FROM alpine:3.14
RUN apk add --no-cache ca-certificates
COPY --from=build /kubernetes-auth-conf /kubernetes-auth-conf
ENTRYPOINT [ "/kubernetes-auth-conf" ]
