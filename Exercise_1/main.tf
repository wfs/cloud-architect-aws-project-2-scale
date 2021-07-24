# TODO: Designate a cloud provider, region, and credentials
# AWS as the cloud provider
# WARN: need to use environment variables for aws access_key + secret_key
#       and not commit actual values to github!
#       - https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#providers
provider "aws" {
  access_key = "insert_env_var_here"
  secret_key = "insert_env_var_here"
  region     = "ap-southeast-2"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
# Use an existing VPC ID: vpc-0213506ae74d0ff13 | Primary
# Use an existing public subnet - subnet-031a9be82c8684730 | Primary 
resource "aws_instance" "Udacity_T2" {
  count         = "4"
  ami           = "ami-0567f647e75c7bc05"
  instance_type = "t2.micro"
  subnet_id     = "subnet-031a9be82c8684730"
  tags = {
    name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "Udacity_M4" {
  count         = "2"
  ami           = "ami-0567f647e75c7bc05"
  instance_type = "m4.large"
  subnet_id     = "subnet-031a9be82c8684730"
  tags = {
    name = "Udacity M4"
  }
}

