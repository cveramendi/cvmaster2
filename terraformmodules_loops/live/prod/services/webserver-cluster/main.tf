provider "aws" {
  region = "us-west-1"
}

module "webserver_cluster" {
  # Since the terraform-up-and-running-code repo is open source, we're using an HTTPS URL here. If it was a private
  # repo, we'd instead use an SSH URL (git@github.com:brikis98/terraform-up-and-running-code.git) to leverage SSH auth
  //source = "github.com/cveramendi/cvmaster2//terraformmodules_part2_modulelocalsoutputs/modules/services/webserver-cluster?ref=v0.1.0"
  source                 = "../../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-up-and-running-state-cvlayout"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
  //instance_type          = "m4.large"
  instance_type          = "t2.micro"
  min_size               = 2
  //max_size               = 10
  max_size               = 4

  custom_tags = {
    Owner = "team-foo"
    DeployedBy = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  //max_size               = 10
  max_size               = 4
  desired_capacity       = 3
  recurrence             = "0 9 * * *"
  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  //max_size               = 10
  max_size               = 4
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
  autoscaling_group_name = module.webserver_cluster.asg_name
}

