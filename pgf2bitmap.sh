#!/bin/bash

OUTTYPE="png" # Standard out type
DENSITY="300" # Standard dpi

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
echo ${POSITIONAL[@]}
((CONVERT_ARG_LEN=${#POSITIONAL[@]} - 1))
CONVERT_ARGS="${POSITIONAL[@]::${CONVERT_ARG_LEN}}"

FILE="${POSITIONAL[-1]}"

if [[ ! -e $FILE ]]; then
	echo "Usage: pgf2bitmap <options> file.pgf"
	exit 1
fi

input_file="$(basename $FILE)"
output_file="${input_file%".pgf"}.${OUTTYPE}"

echo "\documentclass[preview]{standalone}
\usepackage{graphicx}
\graphicspath{{$(dirname $FILE)}}
\usepackage{pgf}
\begin{document}
	\input{$FILE}
\end{document}" > /tmp/pgf2bitmap_temp.tex

pdflatex -shell-escape -output-directory=/tmp /tmp/pgf2bitmap_temp.tex
if (( CONVERT_ARG_LEN > 0 )); then
	convert -density $DENSITY /tmp/pgf2bitmap_temp.pdf "${CONVERT_ARGS[@]}" -flatten $output_file
else
	convert -density $DENSITY /tmp/pgf2bitmap_temp.pdf -flatten $output_file
fi

exit 0
