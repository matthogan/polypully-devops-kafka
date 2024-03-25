resource "kubernetes_namespace" "polypully" {
  metadata {
    name = var.namespace
  }
}
