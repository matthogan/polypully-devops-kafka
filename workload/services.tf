# resource "kubernetes_service" "zookeeper" {
#   metadata {
#     name      = "zookeeper"
#     namespace = var.namespace
#     labels = {
#       app = "zookeeper"
#     }
#   }

#   spec {
#     selector = {
#       app = "zookeeper"
#     }

#     port {
#       name        = "client"
#       protocol    = "TCP"
#       port        = 2181
#       target_port = 2181
#     }

#     type = "ClusterIP"
#   }
# }

# resource "kubernetes_service" "kafka" {
#   metadata {
#     name      = "kafka-service"
#     namespace = var.namespace
#     labels = {
#       app = "kafka"
#     }
#   }

#   spec {
#     selector = {
#       app = "kafka"
#     }

#     port {
#       name        = "client"
#       protocol    = "TCP"
#       port        = 9092
#       target_port = 9092
#     }

#     type = "ClusterIP"
#   }
# }

