FROM alpine:3.12.0

RUN apk add --no-cache shellcheck bash

COPY runaction /action/runaction
ENTRYPOINT ["bash", "/action/runaction"]