
variable "gcp_project_name" {}

variable "helm_repos" {
  type = map(string)
  default = {
    external-secrets = "https://charts.external-secrets.io"
  }
}

variable "external_secrets_helm_chart_version" {
  default = "0.12.1"
}

variable "external_secrets_deployment_replica_count" {
  default     = 1
  description = "Deployment Pod replica count"
  type        = number
}

variable "external_secrets_namespace_name" {
  default = "external-secrets"
  type    = string
}

variable "external_secrets_k8s_account_name" {
  default = "external-secrets-sa"
}

variable "external_secrets_k8s_sa_use_existing" {
  default = true
}

variable "create_gcp_cluster_secret_store" {
  type        = bool
  default     = true
  description = "Whether to create an association to external secret provider - GCP"
}

variable "gcp_cluster_secret_store_name" {
  type        = string
  description = "The name of the GCP Cluster Secret Store. Must follow Kubernetes naming conventions."
  default     = "default-gcp-project-cluster-store"

  validation {
    condition     = can(regex("^([a-z0-9][-a-z0-9]{0,61}[a-z0-9])?$", var.gcp_cluster_secret_store_name))
    error_message = "The name must consist of lowercase alphanumeric characters or '-', start with a letter or number, and be between 1 and 63 characters long."
  }
}

variable "use_new_kubernetes_manifest" {
  description = "Use kubernetes_manifest instead of kubectl_manifest"
  type        = bool
  default     = false
}
