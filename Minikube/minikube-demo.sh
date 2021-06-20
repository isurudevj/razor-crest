#!/bin/sh

FUNCTION=$1

CLUSTER_NAME=local-apps
NODE_NAME=${CLUSTER_NAME}

start() {
  echo "Starting minikube"  
  minikube delete -p ${CLUSTER_NAME}
  minikube start -p ${CLUSTER_NAME} --driver=virtualbox --nodes=3
}

node_name() {
    NODE_NAME=${CLUSTER_NAME}
    if [ "$1" -gt 1 ]
      then
        NODE_ID=$(printf "m%02d" "$1")
        NODE_NAME=${CLUSTER_NAME}-${NODE_ID}
    fi
}

delete() {
  echo "Delete minikube cluster"
  minikube delete -p ${CLUSTER_NAME}
}

ssh() {
  node_name "$1"
  minikube ssh --node="${NODE_NAME}" -p ${CLUSTER_NAME}
}

mount() {
  echo "Mounting the directory $(basename "$1")"
  minikube mount "$1":/app/"$(basename "$1")" -p ${CLUSTER_NAME}
}

scp() {
  echo "Coping file $1 to /tmp/ for the ${CLUSTER_NAME}"
  minikube cp $1 /tmp/$1 -p ${CLUSTER_NAME}
}

delete_node() {
  node_name "$1"
  echo "$NODE_NAME"
}

case $FUNCTION in
start)
  start
  ;;
bar)
  bar
  ;;
ssh)
  shift; ssh $@
  ;;
scp)
  shift; scp $@
  ;;
delete_node)
  shift; delete_node $@
  ;;
mount)
  shift; mount $@
  ;;
*)
  echo "Sorry, I don't understand"
  ;;
esac
