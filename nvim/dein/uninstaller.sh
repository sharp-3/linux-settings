#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
rm \
	"${SCRIPT_DIR}/cache_nvim" \
	"${SCRIPT_DIR}/state_nvim.vim"
rm -rf \
	"${SCRIPT_DIR}/.cache/" \
	"${SCRIPT_DIR}/repos/"
