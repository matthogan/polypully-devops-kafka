#!/usr/bin/env bash

cd kafka_2.12-3.6.1

bin/kafka-console-consumer.sh --topic download --bootstrap-server localhost:9092
