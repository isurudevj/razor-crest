# MINIKUBE Cheat Sheet

## Start minikube with multiple nodes

### 1. Starting for failover testing

Starting minikube with multiple nodes for some firework !!!

<table>
    <tr>
        <th>Option</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>driver</td>
        <td>Specify value 'virtualbox'</td>
    </tr>
    <tr>
        <td>node</td>
        <td>Number of nodes you need</td>
    </tr>
</table>

```shell
    minikube start --driver=virtualbox --nodes=3 start
```

### 2. Working with multiple nodes

List nodes with details

```shell
    minikube node list
```

Stop node in cluster

minikube-m02 in bellow example is identified from output of `list` command.

```shell
    minikube node stop minikube-m02
```