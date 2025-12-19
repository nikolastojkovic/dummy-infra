terraform {
  backend "s3" {
    bucket       = "nikola-tf-state-demo"
    key          = "staging/app_infra.tfstate"
    region       = "eu-central-1"   # region of your STATE bucket (NOT the env region)
    encrypt      = true
    use_lockfile = true
  }
}
