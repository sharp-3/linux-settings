#!/bin/bash

git_clone() {
	mkdir -p "$1"
	pushd "$1"
	git clone "$2"
	if [ -n $3 ]; then
		pushd "${2##*/}"
		git checkout $3
		popd
	fi
	popd
}

git_clone ~/.config/nvim/dpp/repos/github.com/Shougo      https://github.com/Shougo/dpp.vim           456c8f80cb763d32c77f87399e53b37adddee460
git_clone ~/.config/nvim/dpp/repos/github.com/Shougo      https://github.com/Shougo/dpp-ext-toml      3e2390478eb194e24487fa2de225596135f94749
git_clone ~/.config/nvim/dpp/repos/github.com/Shougo      https://github.com/Shougo/dpp-ext-lazy      b19a52bbb6e35dec2c681423b0709cd41f38eb2b
git_clone ~/.config/nvim/dpp/repos/github.com/Shougo      https://github.com/Shougo/dpp-ext-installer ac522815ee9cd2cb62c21c453dd1e54e35fde1fa
git_clone ~/.config/nvim/dpp/repos/github.com/Shougo      https://github.com/Shougo/dpp-protocol-git  582159dda8579f8d954d6e689d57ffbceaeaf17d
git_clone ~/.config/nvim/dpp/repos/github.com/vim-denops  https://github.com/vim-denops/denops.vim    886bfa038d75d415677f8a7a62e8940c74554707
