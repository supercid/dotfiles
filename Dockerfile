FROM debian:stretch-slim

RUN apt-get update && \
	apt-get install -yqq sudo git curl tar fish

RUN adduser --disabled-password --gecos '' cid
RUN adduser cid sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY . /home/cid/.dotfiles
USER cid
WORKDIR /home/cid

# Setup git fake user/email"
RUN git config --global user.name "dotfiles demo" && \
	git config --global user.email "dotfiles@demo.com"

WORKDIR /home/cid/.dotfiles
RUN ./script/bootstrap.fish