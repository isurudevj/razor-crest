# Installing kafka

### 1. Start zookeeper and kafka

```shell
    sh kafka_manage.sh start
```

### 2. Port forward to kafka listen port

```shell
    sh kafka_manage.sh port-forward
```

### 3. Create topic

```shell
    sh kafka_manage.sh topic <topic-name> <partition-count>
```

Example:

```shell
    sh kafka_manage.sh topic my-topic1 1
```

### 4. Clean up after use

```shell
    sh kafka_manage.sh clean
```
