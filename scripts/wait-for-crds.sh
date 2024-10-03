timeout=60
interval=5
end=$((SECONDS+timeout))

while [ $SECONDS -lt $end ]; do
  if kubectl get crd clustersecretstores.external-secrets.io > /dev/null 2>&1; then
    kubectl wait --for=condition=established --timeout=${timeout}s crd/clustersecretstores.external-secrets.io
    exit 0
  else
    echo "Waiting for CRD clustersecretstores.external-secrets.io to be created..."
    sleep $interval
  fi
done

echo "Timed out waiting for CRD clustersecretstores.external-secrets.io"
exit 1