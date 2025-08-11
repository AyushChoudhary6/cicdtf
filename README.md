# Terraform CI/CD Infrastructure Project

This project demonstrates Infrastructure as Code (IaC) using Terraform with CI/CD pipeline integration. It creates a basic AWS infrastructure including VPC, subnet, security group, and EC2 instance.

## 🏗️ Architecture Overview

The infrastructure includes the following AWS resources:

- **VPC**: Custom Virtual Private Cloud (10.0.0.0/16)
- **Subnet**: Public subnet (10.0.1.0/24) in us-east-1a
- **Security Group**: Allows SSH access (port 22) from anywhere
- **EC2 Instance**: t2.micro instance running in the public subnet

## 📁 Project Structure

```
cicdtf/
├── main.tf                 # Main Terraform configuration with modules
├── backend.tf              # S3 backend configuration for state management
├── provider.tf             # AWS provider configuration
├── variables.tf            # Global variables
├── .gitlab-ci.yml         # GitLab CI/CD pipeline configuration
├── vpc/
│   ├── main.tf            # VPC, subnet, and security group resources
│   ├── output.tf          # VPC module outputs
│   └── variables.tf       # VPC module variables
└── web/
    ├── main.tf            # EC2 instance configuration
    ├── output.tf          # Web module outputs
    └── variables.tf       # Web module variables
```

## 🚀 Resources Created

### VPC Module (`./vpc/`)
- **AWS VPC**: 
  - CIDR: `10.0.0.0/16`
  - DNS support and hostnames enabled
  - Tag: `myvpc`

- **Public Subnet**:
  - CIDR: `10.0.1.0/24`
  - Availability Zone: `us-east-1a`
  - Auto-assign public IP enabled
  - Tag: `pb_sn1`

- **Security Group**:
  - Name: `my_sg`
  - Ingress: SSH (port 22) from 0.0.0.0/0
  - Egress: All traffic allowed
  - Tag: `my_security_group`

### Web Module (`./web/`)
- **EC2 Instance**:
  - AMI: `ami-020cba7c55df1f615` (Ubuntu/Amazon Linux)
  - Instance Type: `t2.micro`
  - Attached to public subnet and security group
  - Tag: `myserver`

## 🔧 Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured with credentials
3. **Terraform** installed (version >= 1.0)
4. **S3 Bucket** for state storage: `terrafroms3bucket1102`
5. **DynamoDB Table** for state locking: `backend`

## 📋 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/AyushChoudhary6/cicdtf.git
cd cicdtf
```

### 2. Configure AWS Credentials
```bash
aws configure
# Enter your AWS Access Key ID, Secret Access Key, and region (us-east-1)
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Plan the Deployment
```bash
terraform plan
```

### 5. Apply the Configuration
```bash
terraform apply
```

## 🔄 CI/CD Pipeline

The project includes a GitLab CI/CD pipeline (`.gitlab-ci.yml`) with the following stages:

### Pipeline Stages
1. **Validate**: Check Terraform syntax and configuration
2. **Plan**: Generate execution plan
3. **Apply**: Deploy infrastructure (manual trigger)
4. **Destroy**: Clean up resources (manual trigger)

### Required GitLab Variables
Configure these in GitLab Project Settings → CI/CD → Variables:

| Variable Name | Description | Type |
|---------------|-------------|------|
| `MY_AWS_ACCESS_KEY` | AWS Access Key ID | Variable |
| `MY_SECRET_ACCESS_KEY` | AWS Secret Access Key | Variable (Masked) |

### Pipeline Features
- **Terraform Docker Image**: Uses official Terraform image
- **State Management**: S3 backend with DynamoDB locking
- **Manual Approval**: Apply and Destroy require manual triggers
- **Artifact Storage**: Plan files stored as pipeline artifacts

## 💰 Cost Estimation

### Free Tier Eligible:
- **VPC, Subnet, Security Group**: Free
- **EC2 t2.micro**: 750 hours/month free
- **S3 Storage**: First 5GB free

### Potential Costs (after free tier):
- **EC2 t2.micro**: ~$8.50/month
- **S3 Storage**: ~$0.02/GB/month
- **DynamoDB**: Minimal for state locking

## 🔒 Security Considerations

⚠️ **Current Security Issues:**
- Security group allows SSH from anywhere (0.0.0.0/0)
- No key pair specified for EC2 instance

🛡️ **Recommended Improvements:**
- Restrict SSH access to specific IP ranges
- Add key pair for EC2 access
- Enable VPC Flow Logs
- Use IAM roles instead of hardcoded credentials

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

Or use the GitLab pipeline destroy stage.


## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Note**: Remember to destroy resources after testing to avoid unnecessary charges!


