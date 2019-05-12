#!/usr/bin/env sh

find /build -type f -exec sh -c 'echo "Installing $(basename {})"; cp {} /dest/' \;
