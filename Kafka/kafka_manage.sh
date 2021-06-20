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

case $INPUT in
  ssh)
    shift; ssh "$@"
    ;;
  logs)
    shift; logs "$@"
    ;;
  *)
    echo "Sorry didn't understand"
    ;;
esac