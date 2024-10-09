terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "web_host" {
  ami           = "${var.ami}"
  instance_type = "t2.nano"

  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-west-2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF
  tags = {
    yor_name  = "web_host"
    yor_trace = "ab71c4a0-52fa-4b24-bbe8-9ea53948dc57"
  }
}



resource "aws_ebs_volume" "ebs-web-storage" {
  availability_zone = "${var.region}a"
  size              = 40
  tags = {
    yor_name  = "ebs-web-storage"
    yor_trace = "7ebc23f5-b638-47b6-95d1-7612ba7787a9"
  }
}


resource "aws_s3_bucket" "test_bucket" {
  bucket        = "my-test-bucket"
  force_destroy = true
  acl           = "public-read"
  tags = {
    yor_name  = "test_bucket"
    yor_trace = "d2d37441-82e9-489e-b100-b56b81e10cf1"
  }
}