#!/bin/bash
#
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

function log () {
    echo "$1" # >> /tmp/klg.log
}

while getopts "n:p:c:N:P:C:h" opt; do
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
        h)
            cat "$SCRIPT_PATH/help.txt"
            exit
            ;;
    esac
done

if [[ -z "$NAMESPACE" ]]
then
    NAMESPACE=$("$SCRIPT_PATH/kns.sh" "$NAMESPACE_KEYWORD")
fi

if [[ $? -ne 0 ]]
then
    log "Namespace not found"
    exit 1 # Namespace not found
fi

log "Found namespace: $NAMESPACE"

if [[ -z "$POD" ]]
then
    POD=$("$SCRIPT_PATH/kpod.sh" -N "$NAMESPACE" "$POD_KEYWORD")
fi

if [[ $? -ne 0 ]]
then
    log "Pod not found"
    exit 1 # Pod not found
fi

log "Found pod: $POD"

if [[ -z "$CONTAINER" ]]
then
    CONTAINER=$("$SCRIPT_PATH/kctn.sh" -N "$NAMESPACE" -P "$POD" "$CONTAINER_KEYWORD")
fi

if [[ $? -ne 0 ]]
then
    log "Container not found"
    exit 1 # Container not found
fi

log "Found container: $CONTAINER"

mkdir -p "/tmp/klg"

LOG_FILE="/tmp/klg/$POD.log"

log "Pod log is stored at $LOG_FILE"
kubectl logs -f "pods/$POD" -n "$NAMESPACE" -c "$CONTAINER" > "$LOG_FILE" &

PID=$(jobs -lp)
log "Reading pod logs in background process $PID"

lnav "$LOG_FILE"

log "Killing background process $PID"
kill -s INT "$PID"

log "Removing temporary log file $LOG_FILE"
rm "$LOG_FILE"
