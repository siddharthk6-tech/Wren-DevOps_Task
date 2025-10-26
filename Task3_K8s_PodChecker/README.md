# Task 3 - Kubernetes Pod Diagnostic Script

## Description
Bash script to identify all the Kubernetes pods in non-running states.

## Functionality
The script performs:
1. Lists pods not in **Running** or **Completed** states.
2. Displays the **node** where the pod failed.
3. Lists **events** related to the pod and node.
4. Extracts the **last 100 log lines** from the pod.

## How to Run it
chmod +x pod_diagnose.sh
./pod_diagnose.sh

The script correctly identified the problematic pods and displayed their logs, node events, and failure details.
