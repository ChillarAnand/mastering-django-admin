#! /bin/sh

set -x

make latexpdf
mv _build/latex/*.pdf .
rm -rf _build
open *.pdf
