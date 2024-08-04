#!/bin/bash
docker build --build-arg DOTNET_SDK_VERSION=6.0 . -t dev:6.0
docker build . -t dev:8.0
