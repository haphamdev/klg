#!/bin/bash

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

if [[ -z "$POD" ]]
then
    POD=$(./kpod.sh -N $NAMESPACE $POD_KEYWORD)
fi

if [[ -z "$CONTAINER" ]]
then
    echo Container keyword is: $CONTAINER_KEYWORD
    CONTAINER=$(./kctn.sh -N $NAMESPACE -P $POD $CONTAINER_KEYWORD)
fi

kubectl logs pods/$POD -n $NAMESPACE -c $CONTAINER
