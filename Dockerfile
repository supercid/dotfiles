FROM debian:trixie-slim AS base

RUN apt-get update && \
	apt-get install -yqq sudo git curl tar fish grc

RUN adduser --disabled-password --gecos '' cid
RUN adduser cid sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY --chown=cid:cid . /home/cid/.dotfiles
USER cid
WORKDIR /home/cid
ENV SHELL=/usr/bin/fish

# Setup git fake user/email"
RUN git config --global user.name "dotfiles demo" && \
	git config --global user.email "dotfiles@demo.com"

WORKDIR /home/cid/.dotfiles
RUN ./script/bootstrap.fish --linux
CMD ["fish", "-l"]

# --- docker-outside-of-docker: docker CLI only, talks to a mounted host socket
FROM base AS dood
USER root
ARG COMPOSE_VERSION=v5.3.1
ARG BUILDX_VERSION=v0.35.0
ARG TARGETARCH
RUN apt-get update && \
	apt-get install -yqq docker-cli && \
	rm -rf /var/lib/apt/lists/* && \
	groupadd -f docker && \
	adduser cid docker
# the docker.io/docker-cli packages don't ship the compose or a recent buildx
# plugin (compose v5 needs buildx >= 0.17); install the official binaries so
# `docker compose` and `docker compose build` work
RUN set -eux; \
	case "$TARGETARCH" in \
		amd64) carch=x86_64 ;; \
		arm64) carch=aarch64 ;; \
		*) echo "unsupported arch $TARGETARCH"; exit 1 ;; \
	esac; \
	mkdir -p /usr/local/lib/docker/cli-plugins; \
	curl -sSfL "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-linux-$carch" \
		-o /usr/local/lib/docker/cli-plugins/docker-compose; \
	curl -sSfL "https://github.com/docker/buildx/releases/download/$BUILDX_VERSION/buildx-$BUILDX_VERSION.linux-$TARGETARCH" \
		-o /usr/local/lib/docker/cli-plugins/docker-buildx; \
	chmod +x /usr/local/lib/docker/cli-plugins/docker-compose /usr/local/lib/docker/cli-plugins/docker-buildx; \
	docker buildx version; \
	docker compose version
USER cid
CMD ["fish", "-l"]

# --- docker-in-docker: full engine, a nested daemon is started at runtime
FROM base AS dind
USER root
ARG COMPOSE_VERSION=v5.3.1
ARG BUILDX_VERSION=v0.35.0
ARG TARGETARCH
RUN apt-get update && \
	apt-get install -yqq docker.io && \
	rm -rf /var/lib/apt/lists/* && \
	adduser cid docker
# compose v5 needs buildx >= 0.17; neither ships in docker.io, install both
RUN set -eux; \
	case "$TARGETARCH" in \
		amd64) carch=x86_64 ;; \
		arm64) carch=aarch64 ;; \
		*) echo "unsupported arch $TARGETARCH"; exit 1 ;; \
	esac; \
	mkdir -p /usr/local/lib/docker/cli-plugins; \
	curl -sSfL "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-linux-$carch" \
		-o /usr/local/lib/docker/cli-plugins/docker-compose; \
	curl -sSfL "https://github.com/docker/buildx/releases/download/$BUILDX_VERSION/buildx-$BUILDX_VERSION.linux-$TARGETARCH" \
		-o /usr/local/lib/docker/cli-plugins/docker-buildx; \
	chmod +x /usr/local/lib/docker/cli-plugins/docker-compose /usr/local/lib/docker/cli-plugins/docker-buildx; \
	docker buildx version; \
	docker compose version
COPY script/dockerd-entrypoint.sh /usr/local/bin/dockerd-entrypoint
RUN chmod +x /usr/local/bin/dockerd-entrypoint
ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint"]
CMD ["fish", "-l"]