FROM ghcr.io/vanilla-os/desktop:main
LABEL maintainer='self-maintained'
ARG DEBIAN_FRONTEND=noninteractive
ADD includes.container /
ADD sources /sources
RUN lpkg --unlock && apt-get update
RUN echo Example output
RUN bash /deb-pkgs/install-debs.sh && rm -rf /deb-pkgs
RUN apt-get update && apt-get install -y ca-certificates curl && install -m 0755 -d /etc/apt/keyrings
RUN apt-get update && curl -fsSL https://get.docker.com | sh
RUN apt-get autoremove -y && apt-get clean && lpkg --lock
RUN rm -rf /tmp/* && rm -rf /var/tmp/* && rm -rf /sources
