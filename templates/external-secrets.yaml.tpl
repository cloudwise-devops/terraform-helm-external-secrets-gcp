%{ if node_type != "any" }
global:
  nodeSelector:
    cloud.google.com/gke-provisioning: ${node_type}
%{ endif }
certController:
  log:
    level: error
  securityContext:
    runAsUser: 65534
rbac:
  create: true
serviceAccount:
  name: ${sa_name}
  create: false
replicaCount: ${deployment_replica_count}
podAnnotations: {}
podLabels: {}