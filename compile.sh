#!/usr/bin/env bash
TARGET="${1:-main.tex}"
BASENAME="${TARGET%.*}"

mkdir -p build

echo "[Opalith] Compiling $TARGET (Pass 1/2)..."
pdflatex -interaction=nonstopmode -file-line-error -output-directory=build "$TARGET" || {
    echo "[Opalith] Compilation failed. Check build/$BASENAME.log"
    exit 1
}

echo "[Opalith] Compiling $TARGET (Pass 2/2 for TOC and references)..."
pdflatex -interaction=nonstopmode -file-line-error -output-directory=build "$TARGET" || {
    echo "[Opalith] Compilation failed. Check build/$BASENAME.log"
    exit 1
}

echo "[Opalith] Compilation successful: build/$BASENAME.pdf"
