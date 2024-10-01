variable "helm_repos" {
  type = map(string)
  default = {
    external-secrets = "https://charts.external-secrets.io"
  }
}

variable "external_secrets_helm_chart_version" {
  default = "0.10.4"
}


variable "external_secrets_poller_internal" {
  default     = 10000
  description = "Set POLLER_INTERVAL_MILLISECONDS from GCP"
  type        = number
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

variable "gcp_project_name" {}


variable "external_secrets_k8s_account_name" {
  default = "external-secrets-sa"
}

variable "external_secrets_k8s_sa_use_existing" {
  default = true
}