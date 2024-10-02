<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.15.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.32.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external-secrets-wordload-identity"></a> [external-secrets-wordload-identity](#module\_external-secrets-wordload-identity) | terraform-google-modules/kubernetes-engine/google//modules/workload-identity | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.kubernetes-external-secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.gcp_cluster_secret_store](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.kubernetes-external-secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_service_account.external_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_gcp_cluster_secret_store"></a> [create\_gcp\_cluster\_secret\_store](#input\_create\_gcp\_cluster\_secret\_store) | Whether to create an association to external secret provider - GCP | `bool` | `false` | no |
| <a name="input_external_secrets_deployment_replica_count"></a> [external\_secrets\_deployment\_replica\_count](#input\_external\_secrets\_deployment\_replica\_count) | Deployment Pod replica count | `number` | `1` | no |
| <a name="input_external_secrets_helm_chart_version"></a> [external\_secrets\_helm\_chart\_version](#input\_external\_secrets\_helm\_chart\_version) | n/a | `string` | `"0.10.4"` | no |
| <a name="input_external_secrets_k8s_account_name"></a> [external\_secrets\_k8s\_account\_name](#input\_external\_secrets\_k8s\_account\_name) | n/a | `string` | `"external-secrets-sa"` | no |
| <a name="input_external_secrets_k8s_sa_use_existing"></a> [external\_secrets\_k8s\_sa\_use\_existing](#input\_external\_secrets\_k8s\_sa\_use\_existing) | n/a | `bool` | `true` | no |
| <a name="input_external_secrets_namespace_name"></a> [external\_secrets\_namespace\_name](#input\_external\_secrets\_namespace\_name) | n/a | `string` | `"external-secrets"` | no |
| <a name="input_external_secrets_poller_internal"></a> [external\_secrets\_poller\_internal](#input\_external\_secrets\_poller\_internal) | The amount of time before the values reading again from the SecretStore provider | `string` | `"10m"` | no |
| <a name="input_gcp_cluster_secret_store_name"></a> [gcp\_cluster\_secret\_store\_name](#input\_gcp\_cluster\_secret\_store\_name) | The name of the GCP Cluster Secret Store. Must follow Kubernetes naming conventions. | `string` | n/a | yes |
| <a name="input_gcp_project_name"></a> [gcp\_project\_name](#input\_gcp\_project\_name) | n/a | `any` | n/a | yes |
| <a name="input_helm_repos"></a> [helm\_repos](#input\_helm\_repos) | n/a | `map(string)` | <pre>{<br>  "external-secrets": "https://charts.external-secrets.io"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->