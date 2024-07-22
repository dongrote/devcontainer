#!/bin/bash
docker run -it --rm -v "$(pwd):$HOME/work" -w $HOME/work -e HOME=$HOME -u $(id -u):$(id -g) dev
