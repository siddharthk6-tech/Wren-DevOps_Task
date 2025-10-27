# Task 3 - Kubernetes Pod Diagnostic Script

## Description
Bash script to identify all the Kubernetes pods in non-running states.

## Functionality
The script performs:
1. Lists all pods that are not **Running** or **Completed** states.
2. Displays the **node** where the pod failed.
3. Lists **events** related to the pod and node.
4. Extracts the **last 100 log lines** from the pod.

## How to Run it
chmod +x pod_diagnose.sh
./pod_diagnose.sh

## Outputs
The script correctly identifies the problematic pods and displays their logs, node events, and failure details.
[Click here to view the script output](https://github.com/siddharthk6-tech/Wren-DevOps_Task/blob/main/Task3_K8s_PodChecker/Outputs/kubernetes_pod_diagnose_task_output.png)


