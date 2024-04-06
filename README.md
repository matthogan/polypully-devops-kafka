# polypully-devops-kafka

Terraform deployment of a simple Kafka network with a single downloader service.

## Static & Workload

Static resources are the infrastructural components such as volumes and namespaces.

Workload resource are the dynamic components that require the infrastructural components.

## Running Terraform in static and workload directories

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply -auto-approve
```

```bash
terraform destroy -auto-approve
```

## Test k8s connection

```bash
# Create a YAML file for your pod configuration
cat <<EOF > pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: sample-pod
spec:
  containers:
  - name: sample-container
    image: nginx:latest
    ports:
    - containerPort: 80
EOF

# Apply the YAML file to create the pod
kubectl apply -f pod.yaml

# Check the status of the pod
kubectl get pods

# View detailed information about the pod
kubectl describe pod sample-pod
```
