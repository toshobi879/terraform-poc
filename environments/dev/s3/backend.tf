terraform {
  backend "s3" {
    bucket         = "terraform-s3-state"
    key            = "dev/s3/s3.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
