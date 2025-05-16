terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_instance" "free_tier_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = var.instance_name
  }
}

//s3
resource "aws_s3_bucket" "devops_bucket" {
  bucket = "devops-bucket-saksures"
  
}



# 33333333
resource "aws_s3_bucket" "mybucket" {
  bucket = var.devops-bucket-saksures
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.devops_bucket.id 

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#maade public bucket
resource "aws_s3_bucket_public_access_block" "devops-bucket-saksures" {
  bucket = aws_s3_bucket.devops_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "devops_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.devops_bucket,
  ]

  bucket = aws_s3_bucket.devops_bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.devops_bucket.id
  key = "index.html"
  source = "index.html"
  # acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.devops_bucket.id
  index_document {
    suffix = "index.html"
  }

  depends_on = [ aws_s3_bucket_acl.devops_bucket ]
}