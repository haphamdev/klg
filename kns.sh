#!/bin/bash
# Fuzzy search for k8s namespace
# If argument is not provided, use K8S_DEFAULT_NS or interactively fuzzy search
if [ -z "$1" ]
then
    if [ -z "$K8S_DEFAULT_NS" ]
    then
        kubectl get namespace | awk '{print $1}' \
        | tail -n +2 | fzf --height=40% --border --reverse --header="Select namespace:"
    else
        echo "$K8S_DEFAULT_NS"
    fi
else
    kubectl get namespace | awk '{print $1}' | tail -n +2 | fzf --filter $1 || head -1
fi

