#!/bin/bash
INPUT=$1


ssh() {
    SERVICE_NAME=$1
    echo "$SERVICE_NAME"
    POD_NAME=$(kubectl get pods --selector app="${SERVICE_NAME}" --output jsonpath="{.items[0].metadata.name}")
    echo "$POD_NAME"
    kubectl exec -it "$POD_NAME" -- /bin/bash
}

logs() {
  SERVICE_NAME=$1
  echo "$SERVICE_NAME"
  POD_NAME=$(kubectl get pods --selector app="${SERVICE_NAME}" --output jsonpath="{.items[0].metadata.name}")
  echo "$POD_NAME"
  kubectl logs -f "$POD_NAME"
}

port_forward() {
  SERVICE_NAME="$1"
  kubectl port-forward service/"$SERVICE_NAME" 29092
}

case $INPUT in
  ssh)
    shift; ssh "$@"
    ;;
  logs)
    shift; logs "$@"
    ;;
  port-forward)
    shift; port_forward "$@"
    ;;
  *)
    echo "Sorry didn't understand"
    ;;
esac