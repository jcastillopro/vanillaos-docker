FROM ghcr.io/vanilla-os/desktop:main
LABEL maintainer='self-maintained'
ARG DEBIAN_FRONTEND=noninteractive
ADD includes.container /
ADD sources /sources
RUN lpkg --unlock && apt-get update
RUN echo Example output
RUN bash /deb-pkgs/install-debs.sh && rm -rf /deb-pkgs
RUN apt-get update && apt-get install -y ca-certificates curl && install -m 0755 -d /etc/apt/keyrings
RUN apt-get update && apt-get install ca-certificates curl && install -m 0755 -d /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && chmod a+r /etc/apt/keyrings/docker.asc && echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \ $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \ && tee /etc/apt/sources.list.d/docker.list > /dev/null && apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
RUN apt-get autoremove -y && apt-get clean && lpkg --lock
RUN rm -rf /tmp/* && rm -rf /var/tmp/* && rm -rf /sources
