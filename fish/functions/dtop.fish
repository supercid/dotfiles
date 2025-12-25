function dtop
    docker run --rm --name dtop-(random) -v /var/run/docker.sock:/var/run/docker.sock -it ghcr.io/amir20/dtop
end
