#!/bin/bash

usage="$(basename "$0") [-h] [-f filename ] -- Analyze image for Stenographic encryption

where:
    -h show this help text
    -f filename (required)
    -o output file, (optional)
    
"
    

filename=""
speed="default"
threshold="default"
output=""

while getopts ':h:f:fo:' option; do
    case "$option" in
        h) echo "$usage" >&1
           exit 0
           ;;
        f) filename=$OPTARG
           ;;
        s) speed="fast"
           ;;
        t) threshold=$OPTARG
           ;;
        o) output=$OPTARG
           ;;
        \?) "Unknown option -$OPTARG" >&2;
            echo "$usage" >&2
            exit 1
            ;;
        *) echo "Unimplemented option -$OPTARG" >&2; 
           echo "$usage" >&2
           exit 1
           ;;
    esac
done
shift $(($OPTIND - 1))

if [[ -z $filename ]] ; then
    echo "Must specify a file to test." >&2;
    echo "$usage" >&2
    exit 1
fi

if [[ -z $output ]] ; then
    java -jar StegExpose.jar $filename $speed $threshold >&1;
    exit 0
else
    java -jar StegExpose.jar $filename $speed $threshold >$output
    exit 0
fi