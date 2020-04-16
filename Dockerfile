FROM debian:latest

LABEL "name"="shellcheck"
LABEL "maintainer"="AutoGravity"
LABEL "version"="0.0.0"

LABEL "com.github.actions.name"="shellcheck"
LABEL "com.github.actions.description"="Run shell check on ALL shell files in the repository"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="black"

RUN apt update
RUN apt install -y shellcheck

COPY runaction.sh /runaction.sh
RUN chmod +x /runaction.sh

ENTRYPOINT ["/runaction.sh"]
