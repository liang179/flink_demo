```bash
cd /opt/kafka/bin/
./kafka-topics.sh --bootstrap-server localhost:9092 --create --topic test-topic
./kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test-topic
./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --from-beginning

ps -efww
wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/1.17.2/flink-sql-connector-kafka-1.17.2.jar
./bin/sql-client.sh
```

```sql
show databases;

SET execution.runtime-mode=streaming;
SET execution.runtime-mode=batch;

SET sql-client.execution.result-mode=changelog; --table,tableau,changelog
```