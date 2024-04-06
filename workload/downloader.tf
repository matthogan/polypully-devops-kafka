
data "template_file" "downloader_config" {
  template = file("${path.module}/application.yaml")
}

resource "kubernetes_config_map" "downloader_config_configmap" {
  metadata {
    name      = "downloader-config-configmap"
    namespace = var.namespace
  }

  data = {
    "application.yaml" = "${data.template_file.downloader_config.rendered}"
  }
}

resource "kubernetes_deployment" "downloader" {
  metadata {
    name      = "downloader"
    namespace = var.namespace
  }
  depends_on = [kubernetes_deployment.kafka]
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "downloader"
      }
    }
    template {
      metadata {
        labels = {
          app = "downloader"
        }
      }
      spec {
        container {
          image = "github.com/codejago/polypully/downloader:0.1.0"
          name  = "downloader"
          port {
            container_port = 8080
          }
          port {
            container_port = 2112
          }
          volume_mount {
            name       = "download-data"
            mount_path = "/var/local/download"
          }
          volume_mount {
            name       = "storage-data"
            mount_path = "/var/local/storage"
          }
          volume_mount {
            name       = "download-config"
            mount_path = "/app/config"
            read_only  = true
          }
        }
        volume {
          name = "download-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.download_data.metadata[0].name
          }
        }
        volume {
          name = "storage-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.storage_data.metadata[0].name
          }
        }
        volume {
          name = "download-config"
          config_map {
            name = kubernetes_config_map.downloader_config_configmap.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "downloader" {
  metadata {
    name      = "downloader-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "downloader"
    }
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }
  }
}

# resource "kubernetes_service" "prometheus-service" {
#   metadata {
#     name      = "downloader-prometheus"
#     namespace = var.namespace
#   }
#   spec {
#     selector = {
#       app = "downloader"
#     }
#     type = "ClusterIP"
#     port {
#       port        = 2112
#       target_port = 2112
#     }
#   }
# }

