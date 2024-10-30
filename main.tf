
terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "kubectl" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = var.cluster_ca
  token                  = var.access_token
  load_config_file       = false
}

resource "kubernetes_namespace" "kubernetes-external-secrets" {
  metadata {
    name = var.external_secrets_namespace_name
  }
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
  name          = "external-secrets-operator"
  repository    = var.helm_repos.external-secrets
  chart         = "external-secrets"
  version       = var.external_secrets_helm_chart_version
  wait          = true
  wait_for_jobs = true
  force_update  = false
  recreate_pods = true
  set {
    name  = "installCRDs"
    value = "true"
  }
  namespace = kubernetes_namespace.kubernetes-external-secrets.metadata.0.name
  values = [
    templatefile("${path.module}/templates/external-secrets.yaml.tpl",
      {
        sa_name                  = kubernetes_service_account.external_secrets.metadata.0.name
        deployment_replica_count = var.external_secrets_deployment_replica_count
      }
    )
  ]
}

resource "kubectl_manifest" "gcp_cluster_secret_store" {
  count = var.create_gcp_cluster_secret_store == true ? 1 : 0
  yaml_body = templatefile(
    "${path.module}/yaml/gcp_cluster_secret_store.yaml.tpl",
    {
      "gcp_cluster_secret_store_name" = var.gcp_cluster_secret_store_name,
      "gcp_project_name"              = var.gcp_project_name
    }
  )

  depends_on = [
    helm_release.kubernetes-external-secrets
  ]
}