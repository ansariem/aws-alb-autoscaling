provider "aws" {
  region = "us-east-1"
}

#module first lab VPC. we can use it for one more vpc if required, only we have to modify the values from the module ony.
module "first_lab_vpc" {
  source             = "./vpc"
  region             = "us-east-1"
  vpc_cidr           = "10.0.0.0/16"
  public_cidrs       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_cidrs      = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availbility_zone_public = ["us-east-1a", "us-east-1b"]
  availability_zone_private = ["us-east-1c", "us-east-1d"]
  vpc_tag            = "first_lab"
  igw_tag            = "first_lab_igw"
  public_subnet_tag  = "first_lab_public_subnet"
  private_subnet_tag = "first_lab_private_subnet"
}

# My ALB Module

module "alb" {
  source        = "./alb"
  region        = "us-east-1"
  aws_vpc_id    = "${module.first_lab_vpc.aws_vpc_id}"
  subnet1       = "${module.first_lab_vpc.subnet1}"
  subnet2       = "${module.first_lab_vpc.subnet2}"
  key_name      = "ansarivirginiakey"
  iam_profile   = "day7ssm"
  iam_image     = "ami-04ebc3e86c4d05d87"
  instance_type = "t2.micro"
  asg_max       = "6"
  asg_min       = "2"
  asg_desired   = "2"
  

} 


