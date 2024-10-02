
resource "kubernetes_manifest" "gcp_cluster_secret_store" {
  count = var.create_gcp_cluster_secret_store == true ? 1 : 0
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "gcp-${var.gcp_project_name}-cluster-store"
    }
    spec = {
      provider = {
        gcpsm = {
          projectID = var.gcp_project_name
        }
      }
    }
  }
}