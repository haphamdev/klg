#!/bin/bash
# Fuzzy search for k8s namespace
# If argument is not provided, use K8S_DEFAULT_NS or interactively fuzzy search
if [ -z "$1" ]
then
    if [ -z "$K8S_DEFAULT_NS" ]
    then
        echo "default"
    else
        echo "$K8S_DEFAULT_NS"
    fi
else
    FOUND_NAMESPACES=$(kubectl get namespace | awk '{print $1}' | tail -n +2 | fzf --filter "$1") || exit 1
    NAMESPACES=($FOUND_NAMESPACES)
    echo "${NAMESPACES[0]}"
fi
