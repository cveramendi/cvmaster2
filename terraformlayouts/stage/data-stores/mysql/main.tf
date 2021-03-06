terraform {
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.
    bucket         = "terraform-up-and-running-state-cvlayout"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true

  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"

  username = "admin"

  name                = var.db_name
  skip_final_snapshot = true

  password = var.db_password
}
