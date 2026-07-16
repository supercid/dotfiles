#!/bin/sh
# Entrypoint for the docker-in-docker image. Runs as root, starts a nested
# Docker daemon, waits for it, then drops to the cid user to run the command
# (usually a login fish shell). Requires the container to run --privileged, and
# a volume mounted at /var/lib/docker so storage isn't overlay-on-overlay.
set -e

dockerd >/tmp/dockerd.log 2>&1 &

tries=0
while ! docker info >/dev/null 2>&1; do
  tries=$((tries + 1))
  if [ "$tries" -ge 30 ]; then
    echo "dockerd did not become ready in time; last log:" >&2
    tail -n 20 /tmp/dockerd.log >&2
    exit 1
  fi
  sleep 1
done

chgrp docker /var/run/docker.sock 2>/dev/null || true
chmod 660 /var/run/docker.sock 2>/dev/null || true

export HOME=/home/cid
cd "$HOME"
exec setpriv --reuid cid --regid cid --init-groups "$@"
