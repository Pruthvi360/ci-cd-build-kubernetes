## Step 1

```
Create service account in the gcloud account and give 
1. kubernetes admin privilege
2. compute admin privilege
3. service account user privilege
```

## Create service-account json key
```
Download the json key and keep in the terraform dir
```
## Step 2
## install terraform
```
sudo snap install terraform --classic
```
## Step 3
## Terraform init

```
terraform init
terraform plan -var "project_id=<your-project-id>"
terraform apply -var "project_id=<your-project-id>" -auto-approve
```

## Step 4

```
gcloud container clusters get-credentials <gke-cluster-name> --region us-central1 --project <project_id>
```

## Step 5

```
kubectl get nodes
kubectl get pods
```

## Step 6

```
terraform destroy -var "project_id=<your-project-id>" -auto-approve
```
