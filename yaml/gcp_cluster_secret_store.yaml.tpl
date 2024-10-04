apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: ${gcp_cluster_secret_store_name}
spec:
  provider:
    gcpsm:
      projectID: ${gcp_project_name}