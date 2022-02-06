# Cid's dotfiles

> Config files for fish, Editors, Terminals and more.

![screenshot](https://user-images.githubusercontent.com/2778820/55534888-2ec5ca00-56be-11e9-8303-ce0997164b06.png)

## Installation

### Dependencies

First, make sure you have all those things installed:

- `git`: to clone the repo
- `curl`: to download some stuff
- `tar`: to extract downloaded stuff
- `fish`: to actually run the dotfiles
- `sudo`: some configs may need that

### Install

Then, run these steps:

```console
git clone https://github.com/supercid/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
zsh # or just close and open your terminal again.
```

> All changed files will be backed up with a `.backup` suffix.

### Recommended Software

For macOS, I recommend:

- iTerm: a better terminal emulator;
You can install by running 
 `brew cask install iterm2`

- [`diff-so-fancy`](https://github.com/so-fancy/diff-so-fancy):
better git diffs (you'll need to run `dot_update` to apply it);
- [`fzf`](https://github.com/junegunn/fzf):
fuzzy finder, used in `,t` on vim, for example;
- [`bat`](https://github.com/sharkdp/bat)
a cat replacement
- [`exa`](https://github.com/ogham/exa)
a ls replacement
- [`jq`](https://github.com/stedolan/jq)
a json processor with syntax highlighting
- [`starship.rs`](https://starship.rs) the shell we are using
- [`kubectx`](https://github.com/ahmetb/kubectx) for better Kubernetes context and namespace switch;
- [`grc`](https://github.com/garabik/grc) to colorize command's outputs;
- [`gh`](https://github.com/cli/cli) for more GitHub integration with the terminal;


### macOS defaults

You use it by running: **Read and tweak it first**!

```console
$DOTFILES/macos/set-defaults.sh
```

And logging out and in again/restart.

### Default `EDITOR` and `PROJECTS`

The default `EDITOR` right now is `subl`, which is the Sublime Text editor. 
You can change that by adding your custom override.

`PROJECTS` is default to `~/Developer`. The shortcut to that folder in the shell
is `dev`.

### Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Erlang" — you can simply add a `erlang` directory and
put files in there. Anything with an extension of `.fish` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap.fish`.


### Compatibility

Since i pretty much only use macOS, i dropped the support for linux from the 
original fork of this project.

## Personalization

> How to add custom configuration without messing the local repository


### For git

You can just change the default `~/.gitconfig` file, since it includes the
dotfiles managed one.


### For ssh

You can edit the `~/.ssh/config.local` file.


## iTerm 2 tips
I've wrote a detailed instructions of how I use iTerm2 and its various functions.
https://gist.github.com/supercid/1be22a2f5ecd93ea1ce7112aaf929fb8

## License:

- [License](/LICENSE.md)

## Contributing

Feel free to contribute. Pull requests will be automatically
checked/linted with [Shellcheck](https://github.com/koalaman/shellcheck)
and [shfmt](https://github.com/mvdan/sh).

