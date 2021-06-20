#!/bin/bash

INPUT=$1

clean() {
  kubectl delete -f dc-mongo.yml
  kubectl delete -f sc-mongo.yml
}

ssh() {
  POD_NAME=$(kubectl get pods --selector app=local-mongo --output jsonpath="{.items[0].metadata.name}")
  kubectl exec -it $POD_NAME -- /bin/bash
}

start() {
  kubectl apply -f dc-mongo.yml
  kubectl apply -f sc-mongo.yml
  STATUS=$(kubectl get pods --selector app=local-mongo --output jsonpath="{.items[0].status.phase}")
  while [ "$STATUS" != "Running" ]; do
    echo "Waiting for pod to reach Running state current status = ${STATUS}"
    sleep 2
    STATUS=$(kubectl get pods --selector app=local-mongo --output jsonpath="{.items[0].status.phase}")
  done
  kubectl port-forward service/local-mongo 27017
}

case $INPUT in
  start)
    shift; start
    ;;
  clean)
    clean
    ;;
  ssh)
    ssh
    ;;
  *)
    echo "Sorry didnt' understand"
    ;;

esac