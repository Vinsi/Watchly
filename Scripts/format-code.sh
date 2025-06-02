#!/bin/sh
# Start a clean environment
/usr/bin/env -i HOME="$HOME" PATH="$PATH"
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)

if [ "$1" == "" ]; then
  echo "Requires directory"
  exit 1
fi

# run Swiftformat
./mint run swiftformat $1 \
  --swiftversion 5.0 \
  --stripunusedargs closure-only \
  --disable blankLinesAtStartOfScope \
  --patternlet inline \
  --exclude Tests,Generated

if [ $? -ne 0 ]; then
    echo "swiftformat error"
    exit 2
fi

# run Swiftlint
./mint run swiftlint swiftlint lint $1 --config .swiftlint.yml
if [ $? -ne 0 ]; then
    echo "swiftlint error"
    exit 3
fi
