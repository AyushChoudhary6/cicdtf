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

## 📚 Learn More

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Note**: Remember to destroy resources after testing to avoid unnecessary charges!



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/topics/git/add_files/#add-files-to-a-git-repository) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/ayushrjchoudhary2005/cicdtf.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

- [ ] [Set up project integrations](https://gitlab.com/ayushrjchoudhary2005/cicdtf/-/settings/integrations)

## Collaborate with your team

- [ ] [Invite team members and collaborators](https://docs.gitlab.com/ee/user/project/members/)
- [ ] [Create a new merge request](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html)
- [ ] [Automatically close issues from merge requests](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)
- [ ] [Enable merge request approvals](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/)
- [ ] [Set auto-merge](https://docs.gitlab.com/user/project/merge_requests/auto_merge/)

## Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

***

# Editing this README

When you're ready to make this README your own, just edit this file and use the handy template below (or feel free to structure it however you want - this is just a starting point!). Thanks to [makeareadme.com](https://www.makeareadme.com/) for this template.

## Suggestions for a good README

Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.

## Name
Choose a self-explaining name for your project.

## Description
Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage
Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support
Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap
If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing
State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
For open source projects, say how it is licensed.

## Project status
If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.
