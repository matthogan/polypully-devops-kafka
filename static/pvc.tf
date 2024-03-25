
resource "kubernetes_persistent_volume_claim" "zookeeper_data" {
  metadata {
    name      = "zookeeper-data"
    namespace = kubernetes_namespace.polypully.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    selector {
      match_labels = {
        type = "zookeeper-data"
      }
    }
  }
  # WaitForFirstConsumer...
  wait_until_bound = false
}

resource "kubernetes_persistent_volume_claim" "zookeeper_logs" {
  metadata {
    name      = "zookeeper-logs"
    namespace = kubernetes_namespace.polypully.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    selector {
      match_labels = {
        type = "zookeeper-logs"
      }
    }
  }
  wait_until_bound = false
}

resource "kubernetes_persistent_volume_claim" "kafka_data" {
  metadata {
    name      = "kafka-data"
    namespace = kubernetes_namespace.polypully.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    selector {
      match_labels = {
        type = "kafka-data"
      }
    }
  }
  wait_until_bound = false
}

resource "kubernetes_persistent_volume_claim" "download_data" {
  metadata {
    name      = "download-data"
    namespace = kubernetes_namespace.polypully.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    selector {
      match_labels = {
        type = "download-data"
      }
    }
  }
  wait_until_bound = false
}

resource "kubernetes_persistent_volume_claim" "storage_data" {
  metadata {
    name      = "storage-data"
    namespace = kubernetes_namespace.polypully.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    selector {
      match_labels = {
        type = "storage-data"
      }
    }
  }
  wait_until_bound = false
}
