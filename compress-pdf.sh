#!/bin/bash
directorio=finales
if [ ! -d $directorio ]; then
  mkdir $directorio
fi
i=0
for f in *.pdf; do
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$directorio/c_$f" "$f"
  $((i++))
done

echo "it processed $i files"
