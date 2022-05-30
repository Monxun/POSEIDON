terraform {
  backend "s3" {
    bucket         = var.bucket_name
    key            = "./terraform.tfstate"
    region         = var.region
    encrypt        = true
    kms_key_id     = "THE_ID_OF_THE_KMS_KEY"
  }
}

# UPDATE key AND kms_key_id
