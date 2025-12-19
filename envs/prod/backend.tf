terraform {
  backend "s3" {
    bucket       = "nikola-tf-state-demo"
    key          = "prod/app_infra.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}
