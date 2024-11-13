#!/bin/bash

function get_extension() {
    echo "$1" | sed -e 's/.*\./\./'
}

function find_csproj() {
    directory="$1"
    while [[ "$directory" != "/" ]]
    do
        csproj=$(find "$directory" -maxdepth 1 -name '*.csproj' 2>/dev/null | head -1)
        if [[ "$csproj" != "" ]]
        then
            echo "$csproj"
            return 0
        fi

        directory=$(dirname "$directory")
    done

    echo "Can't find a .csproj file; aborting"
    exit 1
}

function dotnet_build() {
    dotnet build $(find_csproj "$1")
}


if [[ "$1" == "" ]]
then
    origin_file="$(realpath .)"
else
    origin_file="$(realpath "$1")"
fi

if [ -d "$origin_file" ]
then
    origin_directory="$origin_file"
else
    origin_directory="$(dirname "$origin_file")"
fi

extension=$(get_extension "$origin_file")
case "$extension" in
    ".cs")
        dotnet_build $(dirname "$origin_file")
        ;;
    ".ts")
        echo "typescript support not ready yet"
        exit 1
        ;;
    *)
        echo "Unrecognized extension '${extension}'"
        exit 1
        ;;
esac
