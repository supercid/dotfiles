# Cid's dotfiles

[![Build Status][tb]][tp] [![Powered by Antibody][ab]][ap]

> Config files for ZSH, Editors, Terminals and more.

![screenshot](https://user-images.githubusercontent.com/2778820/55534888-2ec5ca00-56be-11e9-8303-ce0997164b06.png)



[ap]: https://github.com/getantibody/antibody
[ab]: https://img.shields.io/badge/powered%20by-antibody-blue.svg?style=flat-square
[tb]: https://img.shields.io/travis/supercid/dotfiles/master.svg?style=flat-square
[tp]: https://travis-ci.org/supercid/dotfiles

## Installation

### Dependencies

First, make sure you have all those things installed:

- `git`: to clone the repo
- `curl`: to download some stuff
- `tar`: to extract downloaded stuff
- `zsh`: to actually run the dotfiles
- `sudo`: some configs may need that

### Install

Then, run these steps:

```console
$ git clone https://github.com/supercid/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./script/bootstrap
$ zsh # or just close and open your terminal again.
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


### macOS defaults

You use it by running: **Read and tweak it first**!

```console
$DOTFILES/macos/set-defaults.sh
```

And logging out and in again/restart.

### Themes and fonts being used

Theme is **Monokai Night** and the font is **Meslo LG L DZ for Powerline**.

### Default `EDITOR` and `PROJECTS`

The default `EDITOR` right now is `subl`, which is the Sublime Text editor. 
You can change that by adding your custom override to that variable in `~/.localrc`.

`PROJECTS` is default to `~/Developer`. The shortcut to that folder in the shell
is `dev`. You can override this default in `~/.localrc`.

### Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Erlang" — you can simply add a `erlang` directory and
put files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

### Naming conventions

There are a few special files in the hierarchy:

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **topic/install.sh**: Any file with this name and with exec permission, will
  ran at `bootstrap` and `dot_update` phase, and are expected to install plugins,
  and stuff like that.

### ZSH plugins

This project uses the [powerlevel9k][powerlevel9k] theme with oh-my-zsh and some other
[zsh plugins](/antibody/bundles.txt). All of them managed by [Antibody](http://getantibody.github.io/),
a faster and simpler Antigen-like program written in Go.

[powerlevel9k]: https://github.com/bhilburn/powerlevel9k

### Compatibility

Since i pretty much only use macOS, i dropped the support for linux from the 
original fork of this project. The CI also also runs only for macOS.

## Personalization

> How to add custom configuration without messing the local repository

### For the shell itself

You can add anything you want (secret stuff, for example), to the `~/.localrc`
file.

### For git

You can just change the default `~/.gitconfig` file, since it includes the
dotfiles managed one.


### For ssh

You can edit the `~/.ssh/config.local` file.


### Sublime Text

If you don't like these st3 settings, run:

```console
$ echo 'KEEP_SUBLIME=1' >> ~/.localrc
$ rm -rf "$HOME/Library/Application Support/Sublime Text 3" "$HOME/.config/sublime-text-3"
```

## License:

- [License](/LICENSE.md)

## Contributing

Feel free to contribute. Pull requests will be automatically
checked/linted with [Shellcheck](https://github.com/koalaman/shellcheck)
and [shfmt](https://github.com/mvdan/sh).

