## Step 1

```
Create service account in the gcloud account and give 
1. kubernetes admin privilege
2. compute admin privilege
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
## Terraform init

```
terraform init
terraform plan -var "project_id=<your-project-id>"
terraform apply -var "project_id=<your-project-id>" -auto-approve
```
