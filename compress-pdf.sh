#!/bin/bash
echo "Please enter the directory where the files are [current directory] "
read baseDir
baseDir=${baseDir:-$(pwd)}

echo "Please enter the directory where you want to put your compressed files [compress] "
read compressDir
compressDir=$baseDir"/"${compressDir:-"compress"}

if [ ! -d $compressDir ]; then
  mkdir $compressDir
fi

# ref: https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# ignore case
shopt -s nocaseglob
i=0
for f in $baseDir"/"*.pdf; do
  echo $f
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$compressDir/$(basename $f)" "$f"
  i=$((i + 1))
done

#redo case
shopt -u nocaseglob

echo "it processed $i files"

# restore $IFS
IFS=$SAVEIFS