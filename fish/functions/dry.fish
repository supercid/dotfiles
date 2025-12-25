function dry
    docker run --rm -it --name dry-(random) -v /var/run/docker.sock:/var/run/docker.sock moncho/dry
end
