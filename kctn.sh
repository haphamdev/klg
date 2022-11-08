#!/bin/bash
#

IS_NAMESPACED_IDENTIFIED=false
NAMESPACE=""
IS_POD_IDENTIFIED=false
POD=""

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

if [[ -z "$NAMESPACE" ]]
then
    NAMESPACE=$(./kns.sh $NAMESPACE_KEYWORD)
fi

if [[ $? -ne 0 ]]
then
    exit 1 # Namespace not found
fi

if [[ -z "$POD" ]]
then
    POD=$(./kpod.sh -n $NAMESPACE $POD_KEYWORD)
fi

if [[ $? -ne 0 ]]
then
    exit 1 # Pod not found
fi

CONTAINER_KEYWORD=${!OPTIND}

if [ -z "$CONTAINER_KEYWORD" ]
then
    kubectl get pods $POD -n $NAMESPACE -o jsonpath='{range .spec.containers[*]}{.name}{"\n"}' \
        | fzf --height=40% --border --reverse --header="Select container:"
else
    FOUND_CONTAINERS=$(kubectl get pods $POD -n $NAMESPACE -o jsonpath='{range .spec.containers[*]}{.name}{"\n"}' \
        | fzf --filter $CONTAINER_KEYWORD) || exit 1

    CONTAINERS=($FOUND_CONTAINERS)
    echo ${CONTAINERS[0]}
fi
