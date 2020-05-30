FROM alpine:3.11.6

RUN apk add --no-cache shellcheck bash

COPY runaction.sh /action/runaction.sh
ENTRYPOINT ["bash", "/action/runaction.sh"]