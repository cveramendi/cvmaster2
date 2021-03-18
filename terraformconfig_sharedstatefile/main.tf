provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    #bucket = "terraform-up-and-running-state-cv"
    #key = "global/s3/terraform.tfstate"
    #region = "us-west-1"
    key = "workspaces-example/terraform.tfstate"

    # Replace this with your DynamoDB table name!
    #dynamodb_table = "terraform-up-and-running-locks"
    #encrypt        = true
  }
}

resource "aws_instance" "example" {
  ami           = "ami-031b673f443c2172c"
  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}
