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
