#!/usr/bin/env bash
flutter_rust_bridge_codegen generate \
    -d lib/ffi \
    --rust-output rust/src/ffi
