
variable "kube_config_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config" // Default path, can be overridden
}

variable "namespace" {
  description = "The namespace to deploy the resources"
  type        = string
  default     = "polypully"
}
