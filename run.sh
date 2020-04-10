#! /bin/sh

set -x

make latexpdf
make html
rm *.pdf
mv _build/latex/*.pdf .
# rm -rf _build
open *.pdf
