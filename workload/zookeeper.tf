
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

resource "kubernetes_service" "zookeeper" {
  metadata {
    name      = "zookeeper-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "zookeeper"
    }
    type = "NodePort"
    port {
      port        = 2181
      target_port = 2181
      node_port   = 30181
    }
  }
}
