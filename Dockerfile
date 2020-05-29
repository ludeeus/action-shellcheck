FROM alpine:3.11.6

COPY runaction.sh /action/runaction.sh

RUN apk add --no-cache shellcheck

ENTRYPOINT ["sh", "/action/runaction.sh"]

LABEL "name"="ShellCheck"
LABEL "maintainer"="Ludeeus <hi@ludeeus.dev>"
LABEL "version"="0.1.0"
LABEL "com.github.actions.name"="ShellCheck"
LABEL "com.github.actions.description"="GitHub action for ShellCheck."
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="black"
