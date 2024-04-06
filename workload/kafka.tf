
resource "kubernetes_deployment" "kafka" {
  metadata {
    name      = "kafka"
    namespace = var.namespace
  }
  depends_on = [kubernetes_deployment.zookeeper]
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "kafka"
      }
    }
    template {
      metadata {
        labels = {
          app = "kafka"
        }
      }
      spec {
        container {
          image = "confluentinc/cp-kafka:6.2.0"
          name  = "kafka"
          port {
            container_port = 9092
          }
          env {
            name  = "KAFKA_ZOOKEEPER_CONNECT"
            value = "zookeeper-service:2181"
          }
          env {
            name  = "KAFKA_ADVERTISED_LISTENERS"
            value = "PLAINTEXT://kafka-service:9092"
          }
          env {
            name  = "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR"
            value = "1"
          }
          env {
            name  = "KAFKA_AUTO_CREATE_TOPICS_ENABLE"
            value = "true"
          }
          volume_mount {
            name       = "kafka-data"
            mount_path = "/var/lib/kafka/data"
          }
        }
        volume {
          name = "kafka-data"
          persistent_volume_claim {
            claim_name = "kafka-data"
          }
        }
      }
    }
  }
}

# resource "kubernetes_service" "kafka_nodeport" {
#   metadata {
#     name      = "kafka-nodeport-service"
#     namespace = var.namespace
#   }
#   spec {
#     selector = {
#       app = "kafka"
#     }
#     type = "NodePort"
#     port {
#       port        = 9092
#       target_port = 9092
#       node_port   = 30092
#     }
#   }
# }

resource "kubernetes_service" "kafka_service" {
  metadata {
    name      = "kafka-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "kafka"
    }
    type = "ClusterIP"
    port {
      port        = 9092
      target_port = 9092
    }
  }
}
