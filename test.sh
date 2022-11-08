#!/bin/bash
kubectl get pods -n default | awk '{print $1}' | tail -n +2 | fzf --filter sub || exit 1 | head -1
