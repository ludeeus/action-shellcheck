FROM alpine:3.12.0

RUN apk add --no-cache shellcheck bash

COPY runaction /action/runaction
COPY .github/problem-matcher.json /problem-matcher.json

ENTRYPOINT ["bash", "/action/runaction"]