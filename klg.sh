#!/bin/bash
#
function log () {
    echo "$1" >> /tmp/klg.log
}

while getopts "n:p:c:N:P:C:" opt; do
    case "${opt}" in
        n)
            NAMESPACE_KEYWORD=$OPTARG
            ;;
        N)
            NAMESPACE=$OPTARG
            ;;
        p)
            POD_KEYWORD=$OPTARG
            ;;
        P)
            POD=$OPTARG
            ;;
        c)
            CONTAINER_KEYWORD=$OPTARG
            ;;
        C)
            CONTAINER=$OPTARG
            ;;
    esac
done

if [[ -z "$NAMESPACE" ]]
then
    NAMESPACE=$(./kns.sh $NAMESPACE_KEYWORD)
fi

if [[ $? -ne 0 ]]
then
    log "Namespace not found"
    exit 1 # Namespace not found
fi

log "Found namespace: $NAMESPACE"

if [[ -z "$POD" ]]
then
    POD=$(./kpod.sh -N $NAMESPACE $POD_KEYWORD)
fi

if [[ $? -ne 0 ]]
then
    log "Pod not found"
    exit 1 # Pod not found
fi

log "Found pod: $POD"

if [[ -z "$CONTAINER" ]]
then
    log "Container keyword is: $CONTAINER_KEYWORD"
    CONTAINER=$(./kctn.sh -N $NAMESPACE -P $POD $CONTAINER_KEYWORD)
fi

if [[ $? -ne 0 ]]
then
    log "Container not found"
    exit 1 # Container not found
fi

log "Found container: $CONTAINER"

kubectl logs pods/$POD -n $NAMESPACE -c $CONTAINER
