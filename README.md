# Free Tier AWS Terraform Setup

This Terraform configuration sets up a Free Tier compliant AWS environment with the following resources:

- A custom VPC
- A public subnet
- An Internet Gateway
- A t2.micro EC2 instance
- An S3 bucket (without website hosting)

## Prerequisites

- AWS CLI configured with your credentials
- Terraform installed

## Usage

1. **Initialize Terraform:**  
   ```bash
   terraform init
   ```

2. **Review the plan:**  
   ```bash
   terraform plan
   ```

3. **Apply the configuration:**  
   ```bash
   terraform apply -auto-approve
   ```

4. **To destroy resources:**  
   ```bash
   terraform destroy -auto-approve
   ```
#   T e r r a f o r m  
 