
resource "kubernetes_deployment" "zookeeper" {
  metadata {
    name      = "zookeeper"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "zookeeper"
      }
    }
    template {
      metadata {
        labels = {
          app = "zookeeper"
        }
      }
      spec {
        container {
          image = "confluentinc/cp-zookeeper:6.2.0"
          name  = "zookeeper"
          port {
            container_port = 2181
          }
          env {
            name  = "ZOOKEEPER_CLIENT_PORT"
            value = "2181"
          }
          env {
            name  = "ZOOKEEPER_TICK_TIME"
            value = "2000"
          }
          volume_mount {
            name       = "zookeeper-data"
            mount_path = "/var/lib/zookeeper/data"
          }
          volume_mount {
            name       = "zookeeper-logs"
            mount_path = "/var/lib/zookeeper/logs"
          }
        }
        volume {
          name = "zookeeper-data"
          persistent_volume_claim {
            claim_name = "zookeeper-data"
          }
        }
        volume {
          name = "zookeeper-logs"
          persistent_volume_claim {
            claim_name = "zookeeper-logs"
          }
        }
      }
    }
  }
}

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
            value = "zookeeper:2181"
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

# resource "kubernetes_deployment" "downloader" {
#   metadata {
#     name      = "downloader"
#     namespace = kubernetes_namespace.polypully.metadata[0].name
#   }
#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         app = "downloader"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "downloader"
#         }
#       }
#       spec {
#         container {
#           image = "github.com/codejago/polypully/downloader:0.1.0"
#           name  = "downloader"
#           port {
#             container_port = 8080
#           }
#           volume_mount {
#             name       = "download-data"
#             mount_path = "/var/local/download"
#           }
#           volume_mount {
#             name       = "storage-data"
#             mount_path = "/var/local/storage"
#           }
#         }
#         volume {
#           name = "download-data"
#           persistent_volume_claim {
#             claim_name = kubernetes_persistent_volume_claim.download_data.metadata[0].name
#           }
#         }
#         volume {
#           name = "storage-data"
#           persistent_volume_claim {
#             claim_name = kubernetes_persistent_volume_claim.storage_data.metadata[0].name
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "downloader" {
#   metadata {
#     name      = "downloader-service"
#     namespace = kubernetes_namespace.polypully.metadata[0].name
#   }
#   spec {
#     selector = {
#       app = "downloader"
#     }
#     type = "NodePort"
#     port {
#       port        = 8080
#       target_port = 8080
#       node_port   = 30000
#     }
#   }
# }
