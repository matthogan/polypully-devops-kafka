resource "kubernetes_persistent_volume" "zookeeper_logs_pv" {
  metadata {
    name = "zookeeper-logs-pv"
    labels = {
      type = "zookeeper-logs"
    }
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    persistent_volume_source {
      host_path {
        path = "/data/zookeeper/logs"
        type = "Directory"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "zookeeper_data_pv" {
  metadata {
    name = "zookeeper-data-pv"
    labels = {
      type = "zookeeper-data"
    }
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    persistent_volume_source {
      host_path {
        path = "/data/zookeeper/data"
        type = "Directory"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "kafka_data_pv" {
  metadata {
    name = "kafka-data-pv"
    labels = {
      type = "kafka-data"
    }
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    persistent_volume_source {
      host_path {
        path = "/data/kafka/data"
        type = "Directory"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "download_data" {
  metadata {
    name = "download-data-pv"
    labels = {
      type = "download-data"
    }
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    persistent_volume_source {
      host_path {
        path = "/data/downloader/data"
        type = "Directory"
      }
    }
  }
}

resource "kubernetes_persistent_volume" "storage_data" {
  metadata {
    name = "storage-data-pv"
    labels = {
      type = "storage-data"
    }
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "standard"
    persistent_volume_source {
      host_path {
        path = "/data/downloader/storage"
        type = "Directory"
      }
    }
  }
}
