#!/usr/bin/env bash

cd kafka_2.12-3.6.1

TOPIC=${1:download}

bin/kafka-topics.sh --create --topic "${TOPIC}" --bootstrap-server localhost:9092
