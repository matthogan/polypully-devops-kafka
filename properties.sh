#!/usr/bin/env bash

# Generate the client.properties file
# using the password for user1
# stored in the cluster as a secret
# to be used by the kafka producers and consumers

cat <<EOF > client.properties
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \\
    username="user1" \\
    password="$(kubectl get secret kafka-user-passwords --namespace kafka -o jsonpath='{.data.client-passwords}' | base64 -d | cut -d , -f 1)";
EOF

# Based on the helm chart output

# The CLIENT listener for Kafka client connections from within your cluster have been configured with the following security settings:
#     - SASL authentication

# To connect a client to your Kafka, you need to create the 'client.properties' configuration files with the content below:

# security.protocol=SASL_PLAINTEXT
# sasl.mechanism=SCRAM-SHA-256
# sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
#     username="user1" \
#     password="$(kubectl get secret kafka-user-passwords --namespace kafka -o jsonpath='{.data.client-passwords}' | base64 -d | cut -d , -f 1)";

# To create a pod that you can use as a Kafka client run the following commands:

#     kubectl run kafka-client --restart='Never' --image docker.io/bitnami/kafka:3.6.1-debian-11-r4 --namespace kafka --command -- sleep infinity
#     kubectl cp --namespace kafka /path/to/client.properties kafka-client:/tmp/client.properties
#     kubectl exec --tty -i kafka-client --namespace kafka -- bash

#     PRODUCER:
# kafka-console-producer.sh \
#     --producer.config /tmp/client.properties \
#     --broker-list kafka-controller-0.kafka-controller-headless.kafka.svc.cluster.local:9092,kafka-controller-1.kafka-controller-headless.kafka.svc.cluster.local:9092,kafka-controller-2.kafka-controller-headless.kafka.svc.cluster.local:9092 \
#     --topic test

#     CONSUMER:
#         kafka-console-consumer.sh \
#             --consumer.config /tmp/client.properties \
#             --bootstrap-server kafka.kafka.svc.cluster.local:9092 \
#             --topic test \
#             --from-beginning
# To connect to your Kafka controller+broker nodes from outside the cluster, follow these instructions:
#     Kafka brokers domain: You can get the external node IP from the Kafka configuration file with the following commands (Check the EXTERNAL listener)

#         1. Obtain the pod name:

#         kubectl get pods --namespace kafka -l "app.kubernetes.io/name=kafka,app.kubernetes.io/instance=kafka,app.kubernetes.io/component=kafka"

#         2. Obtain pod configuration:

#         kubectl exec -it KAFKA_POD -- cat /opt/bitnami/kafka/config/server.properties | grep advertised.listeners
#     Kafka brokers port: You will have a different node port for each Kafka broker. You can get the list of configured node ports using the command below:

#         echo "$(kubectl get svc --namespace kafka -l "app.kubernetes.io/name=kafka,app.kubernetes.io/instance=kafka,app.kubernetes.io/component=kafka,pod" -o jsonpath='{.items[*].spec.ports[0].nodePort}' | tr ' ' '\n')"

# The EXTERNAL listener for Kafka client connections from within your cluster have been configured with the following settings:
#     - SASL authentication

# To connect a client to your Kafka, you need to create the 'client.properties' configuration files with the content below:

# security.protocol=SASL_PLAINTEXT
# sasl.mechanism=SCRAM-SHA-256
# sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
#     username="user1" \
#     password="$(kubectl get secret kafka-user-passwords --namespace kafka -o jsonpath='{.data.client-passwords}' | base64 -d | cut -d , -f 1)";