#!/bin/bash

while getopts "N:n:P:p:C:c:" opt; do
    case "${opt}" in
        n) # fuzzy search for namespace if not identified
            NAMESPACE_KEYWORD=$OPTARG
            ;;
        N) # set the namespace
            NAMESPACE="$OPTARG"
            ;;
        p)
            POD_KEYWORD=$OPTARG
            ;;
        P)
            POD=$OPTARG
            ;;
    esac
done

echo $OPTIND
echo ${!OPTIND}
