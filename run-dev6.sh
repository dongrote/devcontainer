#!/bin/bash
docker run -it -v "$(pwd):$HOME/work" -w $HOME/work -e HOME=$HOME -u $(id -u):$(id -g) --name nvim-dotnet-6.0 dev:6.0
