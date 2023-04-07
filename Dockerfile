FROM golang:1.18-alpine
MAINTAINER Allan Nava <allan.nava@hiway.media> (https://hiway.media)

LABEL "com.github.actions.name"="Go Release Binary"
LABEL "com.github.actions.description"="Automate publishing Go build artifacts for GitHub releases"
LABEL "com.github.actions.icon"="cpu"
LABEL "com.github.actions.color"="orange"

LABEL "name"="Automate publishing Go build artifacts for GitHub releases through GitHub Actions"
LABEL "version"="1.2.0"
LABEL "repository"="http://github.com/Allan-Nava/go-release.action"

LABEL "maintainer"="Allan Nava <allan.nava@hiway.media> (https://hiway.media)"

RUN apk add --no-cache curl jq git build-base bash zip

ADD entrypoint.sh /entrypoint.sh
ADD build.sh /build.sh
ENTRYPOINT ["/entrypoint.sh"]