# terraform-helm-external-secrets-gcp
Terraform module to install external secrets on GKE and connect to GCP
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| external\_secrets\_deployment\_replica\_count | Deployment Pod replica count | `number` | `1` | no |
| external\_secrets\_helm\_chart\_version | n/a | `string` | `"8.3.0"` | no |
| external\_secrets\_k8s\_account\_name | n/a | `string` | `"external-secrets-sa"` | no |
| external\_secrets\_k8s\_sa\_use\_existing | n/a | `bool` | `true` | no |
| external\_secrets\_namespace\_name | n/a | `string` | `"external-secrets"` | no |
| external\_secrets\_poller\_internal | Set POLLER\_INTERVAL\_MILLISECONDS from GCP | `number` | `10000` | no |
| gcp\_project\_name | n/a | `any` | n/a | yes |
| helm\_repos | n/a | `map(string)` | <pre>{<br>  "external-secrets": "https://external-secrets.github.io/kubernetes-external-secrets/"<br>}</pre> | no |

## Outputs

No output.

