#!/bin/sh
# Credit to https://github.com/ducaale/xh for this install script.

set -e

if [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "x86_64" ]; then
    target="darwin_amd64"
elif [ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "x86_64" ]; then
    target="linux_amd64"
elif [ "$(uname -s)" = "Linux" ] && ( uname -m | grep -q -e '^arm' -e '^aarch' ); then
    target="linux_arm64"
else
    echo "Unsupported OS or architecture"
    exit 1
fi

echo "Detected target: $target"
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCATION="$CURRENT_PATH/dist/mani_${target}.zip"
echo "path: ${LOCATION}"
if ! test "$LOCATION"; then
    echo "Could not find release info"
    exit 1
fi

temp_dir=$(mktemp -dt mani.XXXXXX)
echo "mktemp: ${temp_dir}"
trap 'rm -rf "$temp_dir"' EXIT INT TERM
cd "$temp_dir"

cp "$LOCATION" ./mani.zip

user_bin="$HOME/.local/bin"
case $PATH in
    *:"$user_bin":* | "$user_bin":* | *:"$user_bin")
        default_bin=$user_bin
        ;;
    *)
        default_bin='/usr/local/bin'
        ;;
esac

printf "Install location [default: %s]: " "$default_bin"
read -r bindir < /dev/tty
bindir=${bindir:-$default_bin}

while ! test -d "$bindir"; do
    echo "Directory $bindir does not exist"
    printf "Install location [default: %s]: " "$default_bin"
    read -r bindir < /dev/tty
    bindir=${bindir:-$default_bin}
done

unzip mani.zip

if test -w "$bindir"; then
    mv mani "$bindir/"
else
    sudo mv mani "$bindir/"
fi
"$bindir"/mani completion bash
"$bindir"/mani --version
