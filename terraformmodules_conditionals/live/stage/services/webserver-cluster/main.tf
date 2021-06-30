provider "aws" {
  region = "us-west-1"
}

module "webserver_cluster" {
  # Since the terraform-up-and-running-code repo is open source, we're using an HTTPS URL here. If it was a private
  # repo, we'd instead use an SSH URL (git@github.com:brikis98/terraform-up-and-running-code.git) to leverage SSH auth
  //source = "github.com/cveramendi/cvmaster2//terraformmodules_part2_modulelocalsoutputs/modules/services/webserver-cluster?ref=v0.2.0"
  source = "../../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-up-and-running-state-cvlayout"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 2
  enable_autoscaling     = false
  enable_new_user_data   = true
}
