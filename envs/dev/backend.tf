terraform {
  backend "s3" {
    bucket       = "nikola-tf-state-demo"
    key          = "dev/app_infra.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
}
