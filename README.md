# 🚀 Terraform Multi-Environment CI/CD (Trunk-Based + GitHub Actions)

This repository demonstrates a clean and realistic **Infrastructure-as-Code (IaC)** setup using:

- **Terraform** (module + 3 environments)
- **Trunk-based development** (`main` as the only long-lived branch)
- **GitHub Actions CI/CD** with a reusable workflow
- **AWS S3 backend with locking**
- **Multi-environment deployment pipeline (dev → staging → prod)**

Because this runs on a **personal AWS account**, environments are simulated using **different AWS regions**, while still preserving a real enterprise-style structure.

---

## 📁 Repository Structure
```
modules/
  app_infra/              # Reusable Terraform module (S3 bucket + EC2 + SG)

envs/
  dev/                    # Dev environment (eu-central-1)
  staging/                # Staging environment (eu-west-1)
  prod/                   # Production environment (us-east-1)

.github/workflows/
  terraform-reusable.yml  # Core plan/apply engine (reusable)
  terraform-dev-ci.yml    # Feature branch plan + PR → dev deploy
  terraform-deploy.yml    # Staging deploy (auto) + Prod deploy (manual)
```


---

## 🌍 Environment Model (One AWS Account → Multiple Regions)

To simulate multi-account separation in a cost-efficient way, each environment maps to a **different AWS region**:

| Environment | AWS Region     | Purpose                     |
|-------------|----------------|-----------------------------|
| **dev**     | eu-central-1   | PR preview environment      |
| **staging** | eu-west-1      | Auto-deploy after merge     |
| **prod**    | us-east-1      | Manual production promotion |

Each environment has its own backend key, provider, tfvars, and configuration.

---

## ☁️ Terraform Remote State

All environments share a single S3 bucket for remote state:

bucket: **nikola-tf-state-demo**

state keys:
- dev/app_infra.tfstate
- staging/app_infra.tfstate
- prod/app_infra.tfstate


The backend uses Terraform's native S3 lockfile:

```hcl
use_lockfile = true
```

---

## 🧩 Terraform Module (modules/app_infra)

The module provisions:

- Secure S3 bucket (public access blocked, encrypted)
- EC2 instance
- Security group
- Randomized bucket suffix for uniqueness
- Environment tags and flexibility via variables
- Each environment configures the module via its own *.tfvars.

---


## 🔄 CI/CD Pipeline (GitHub Actions)

This project uses trunk-based development with main as the single source of truth.

1️⃣ Push to feature/*

- Runs terraform plan on the dev environment.
- This provides early feedback without modifying infrastructure.

2️⃣ Pull Request → Deploy to DEV

Opening a PR into main triggers:

- terraform apply to dev
- Dev acts as a shared preview/testing environment

3️⃣ Merge to main → Auto-Deploy to STAGING

When a PR is merged:

- A push to main triggers terraform apply for staging
- Staging always reflects the latest code in main

4️⃣ Manual Promotion to PROD

- Production deployment requires a manual workflow_dispatch trigger.
- This mirrors real-world approval and release processes.

## 🔐 Security: GitHub OIDC → AWS IAM Roles

GitHub Actions authenticates to AWS using OIDC, not long-lived access keys.

Required repository secrets per environment:

- AWS_ROLE_DEV
- AWS_ROLE_STAGING
- AWS_ROLE_PROD

Each secret contains the ARN of an IAM role with permissions scoped to its environment.

This ensures:
- No stored AWS keys
- Least-privilege separation
- Enterprise-grade CI/CD security

---

## ▶️ Running Terraform Locally

Example for dev:
```
cd envs/dev
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
terraform destroy -var-file="dev.tfvars"
```

Repeat for staging/prod using their respective directories and tfvars files.

## 💡 Notes

A real enterprise setup would use separate AWS accounts per environment.
This repository simulates that model using multiple regions in a single account to minimize cost.
The CI/CD pipeline is intentionally simple and realistic:

- Preview on dev
- Auto-deploy to staging
- Manual promotion to prod
- Reusable workflows keep the code DRY, maintainable, and consistent.

## ✔️ Summary

This project provides:

- Modular Terraform infrastructure
- Three isolated environments
- Remote state with S3 locking
- Reusable GitHub Actions workflows
- Secure AWS OIDC authentication
- Modern trunk-based CI/CD workflow
- Realistic multi-environment promotion
- Low AWS cost footprint
- Perfect foundation for real-world IaC automation or technical assessment submissions.


