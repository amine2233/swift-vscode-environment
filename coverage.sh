#!/bin/bash

BIN_PATH="$(swift build --show-bin-path)"
XCTEST_PATH="$(find ${BIN_PATH} -name '*.xctest')"

COV_BIN="llvm-cov"
COV_PATH=$XCTEST_PATH

if [[ "$OSTYPE" == "darwin"* ]]; then
    f="$(basename $XCTEST_PATH .xctest)"
    COV_PATH="${COV_PATH}/Contents/MacOS/$f"
    COV_BIN="xcrun ${COV_BIN}"
fi

$COV_BIN report \
    "${COV_PATH}" \
    -instr-profile=.build/debug/codecov/default.profdata \
    -ignore-filename-regex=".build|Tests" \
    -use-color
