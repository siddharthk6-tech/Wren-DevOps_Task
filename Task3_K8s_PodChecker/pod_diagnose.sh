#!/bin/bash

echo ">>>>>  Checking for pods in non-running state..."
echo "-----------------------------------------------------------"
echo "-----------------------------------------------------------"

# Get all pods that are NOT Running or Completed
pods=$(kubectl get pods -A | grep -vE 'Running|Completed|STATUS')

# If no such pods, exit
if [ -z "$pods" ]; then
    echo ">>>> All pods are running successfully!"
    exit 0
fi

echo ">>>>> Found pods that are not running or completed:"
echo "$pods"
echo "-----------------------------------------------------------"
echo "-----------------------------------------------------------"
# Loop through each problematic pod
while read -r line; do
    namespace=$(echo "$line" | awk '{print $1}')
    pod=$(echo "$line" | awk '{print $2}')
    status=$(echo "$line" | awk '{print $4}')

    echo ">> Checking pod: $pod (Namespace: $namespace, Status: $status)"
    
    # Get the node where the pod is/was scheduled
    node=$(kubectl get pod "$pod" -n "$namespace" -o jsonpath='{.spec.nodeName}')
    if [ -z "$node" ]; then
        echo "    Pod not yet scheduled on any node."
    else
        echo ">  Node: $node"
    fi

    # Get pod events
    echo "---> Events for this pod:"
    kubectl describe pod "$pod" -n "$namespace" | grep -A 5 "Events:" || echo ">>  No events found."
    
    # Get node events
    if [ -n "$node" ]; then
        echo "---> Node events for $node:"
        kubectl describe node "$node" | grep -A 5 "Events:" || echo ">>  No node events found."
    fi

    # Get last 100 log lines from the pod (if any)
    echo "****Last 100 log lines for this pod****"
    kubectl logs "$pod" -n "$namespace" --tail=100 || echo ">>  No logs found for this pod."

    echo "-----------------------------------------------------------"
    echo "-----------------------------------------------------------"
done <<< "$pods"

