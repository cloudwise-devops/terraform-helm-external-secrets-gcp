resource "kubernetes_namespace" "kubernetes-external-secrets" {
  metadata {
    name = var.external_secrets_namespace_name
  }
}

resource "kubernetes_service_account" "external_secrets" {
  metadata {
    name      = var.external_secrets_k8s_account_name
    namespace = kubernetes_namespace.kubernetes-external-secrets.metadata.0.name
    annotations = {
      "iam.gke.io/gcp-service-account" = module.external-secrets-wordload-identity.gcp_service_account_email
    }
  }
}

resource "helm_release" "kubernetes-external-secrets" {
  name          = "external-secrets"
  repository    = var.helm_repos.external-secrets
  chart         = "kubernetes-external-secrets"
  version       = var.external_secrets_helm_chart_version
  wait          = true
  force_update  = false
  recreate_pods = true
  namespace     = kubernetes_namespace.kubernetes-external-secrets.metadata.0.name
  values = [<<EOF
  env:
    POLLER_INTERVAL_MILLISECONDS: ${var.external_secrets_poller_internal}
    LOG_LEVEL: info
  rbac:
    create: true
  serviceAccount:
    name: ${kubernetes_service_account.external_secrets.metadata.0.name}
    create: false
  replicaCount: ${var.external_secrets_deployment_replica_count}
  podAnnotations: {}
  podLabels: {}
  securityContext:
    fsGroup: 65534
  EOF
  ]
}

module "external-secrets-wordload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name                = var.external_secrets_k8s_account_name
  namespace           = var.external_secrets_namespace_name
  annotate_k8s_sa     = false
  project_id          = var.gcp_project_name
  roles               = ["roles/secretmanager.secretAccessor"]
  use_existing_k8s_sa = var.external_secrets_k8s_sa_use_existing
}

