#!/bin/sh

# Crop all pdfs in this folder
find . -name '*.pdf' -print0 | xargs -0 -I _ pdfcrop _ _
