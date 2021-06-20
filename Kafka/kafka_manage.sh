#!/bin/bash
INPUT=$1

clean() {
  kubectl delete -f dc-kafka.yml
  kubectl delete -f sc-kafka.yml
  kubectl delete -f dc-zookeeper.yml
  kubectl delete -f sc-zookeeper.yml
}

start() {
  kubectl apply -f dc-kafka.yml
  kubectl apply -f sc-kafka.yml
  kubectl apply -f dc-zookeeper.yml
  kubectl apply -f sc-zookeeper.yml
  # TODO add a while loop to check pod status
  kubectl port-forward service/local-kafka 29092
}

topic() {
  TOPIC_NAME=$1
  PARTITION_COUNT=$2
  POD_NAME=$(kubectl get pods --selector app="local-kafka" --output jsonpath="{.items[0].metadata.name}")
  kubectl exec "$POD_NAME" -- kafka-topics --create --topic "$TOPIC_NAME" --partitions "$PARTITION_COUNT" --bootstrap-server localhost:29092
}

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
  kubectl port-forward service/local-kafka 29092
}

case $INPUT in
  ssh)
    shift; ssh "$@"
    ;;
  logs)
    shift; logs "$@"
    ;;
  port-forward)
    shift; port_forward
    ;;
  clean)
    clean
    ;;
  start)
    start
    ;;
  topic)
    shift; topic "$@"
    ;;
  *)
    echo "Sorry didn't understand"
    ;;
esac