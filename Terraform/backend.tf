terraform {
  backend "s3" {
    bucket = "backendbucket-s3-31012024"
	key = "default/terraform.tfstate"
	region = "ap-south-1"
  }
}
