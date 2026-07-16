function dtop -d "docker top TUI (amir20/dtop) with the repo's versioned config"
    # Mount the versioned config dir straight into the container so dtop reads
    # dtop/config.yaml and any edits/saved preferences persist back to the repo.
    # The image runs as root, so ~ resolves to /root once HOME is set.
    set -l dotfiles $DOTFILES
    test -n "$dotfiles"; or set dotfiles $HOME/.dotfiles
    docker run --rm --name dtop-(random) \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e HOME=/root \
        -v $dotfiles/dtop:/root/.config/dtop \
        -it ghcr.io/amir20/dtop $argv
end
