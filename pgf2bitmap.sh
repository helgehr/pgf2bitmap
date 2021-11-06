#!/bin/bash

OUTTYPE="png" # Standard out type
DENSITY="300"

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -t|--type)
      OUTTYPE="$2"
      shift # past argument
      shift # past value
      ;;
    -d|--density)
      DENSITY="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ ! -e $1 ]]; then
    echo "Usage: pgf2bitmap <options> file.pgf"
    exit 1
fi


echo "\documentclass[preview]{standalone}
\usepackage{graphicx}
\graphicspath{{$(dirname $1)}}
\usepackage{pgf}
\begin{document}
    \input{$1}
\end{document}" > /tmp/pgf2bitmap_temp.tex

pdflatex -shell-escape -output-directory=/tmp /tmp/pgf2bitmap_temp.tex
convert -density $DENSITY /tmp/pgf2bitmap_temp.pdf -flatten out.$OUTTYPE

exit 0
