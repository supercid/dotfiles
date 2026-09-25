function dtop -d "docker top TUI (supercid/dtop fork) with the repo's versioned config"
    # Mount the versioned config dir straight into the container so dtop reads
    # dtop/config.yaml and any edits/saved preferences persist back to the repo.
    # The image runs as root, so ~ resolves to /root once HOME is set.
    # --entrypoint drops the image's default CMD (--host local): dtop skips the
    # config file entirely whenever --host is passed, so it has to go.
    set -l dotfiles $DOTFILES
    test -n "$dotfiles"; or set dotfiles $HOME/.dotfiles
    docker run --rm --name dtop-(random) \
        --entrypoint /dtop \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e HOME=/root \
        -v $dotfiles/dtop:/root/.config/dtop \
        -it supercid/dtop $argv
end
