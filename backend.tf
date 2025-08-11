terraform {
  backend "s3" {
    bucket = "terrafroms3bucket1102"
    key    = "state"
    region = "us-east-1"
    dynamodb_table = "backend"
  }
}
