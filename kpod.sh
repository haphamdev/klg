#!/bin/bash
# Fuzzy search for k8s pod
#
# Usage:
# ./kns.sh [options] [pod-keyword]
# Options:
# -N: Exact name of the namespace.
# -n: keyword for fuzzy searching namespace. Ingored if -N is used
# Examples:
# ./kns.sh -n def mypod
# ./kns.sh -N default mypod

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


function log () {
    echo "$1" >> /tmp/kpod.log
}

NAMESPACE_KEYWORD=""
POD=""
NAMESPACE=""

while getopts "N:n:" opt; do
    case "${opt}" in
        n) # fuzzy search for namespace if not identified
            log "Found option n: $OPTARG"
            NAMESPACE_KEYWORD=$OPTARG
            ;;
        N) # set the namespace
            log "Found option N: $OPTARG"
            NAMESPACE=$OPTARG
            ;;
    esac
done

if [ -z "$NAMESPACE" ]
then
    NAMESPACE="$("$SCRIPT_PATH/kns.sh" "$NAMESPACE_KEYWORD")"
fi

log "Found namespace: $NAMESPACE"

if [[ $? -ne 0 ]]
then
    exit 1
fi

POD_KEYWORD=${!OPTIND}

log "looking for pod: $POD_KEYWORD"

if [ -z "$POD_KEYWORD" ]
then
    log "No pod keyword"
    kubectl get pods -n "$NAMESPACE" | awk '{print $1}' \
        | tail -n +2 | fzf --height=40% --border --reverse --header="Select pod:"
else
    log "Pod keyword: '$POD_KEYWORD'"
    FOUND_PODS=$(kubectl get pods -n "$NAMESPACE" | awk '{print $1}' | tail -n +2 | fzf --filter "$POD_KEYWORD") || exit 1
    PODS=($FOUND_PODS)
    echo "${PODS[0]}"
fi
