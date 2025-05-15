variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "FreeTierVPC"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_name" {
  default = "FreeTierPublicSubnet"
}

variable "availability_zone" {
  default = "us-east-1a"
}

# variable "ami_id" {
#   default = "ami-0c55b159cbfafe1f0"
# }

variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "FreeTierInstance"
}

# variable "s3_bucket_name" {
#   default = "free-tier-s3-bucket-terraform"
# }

variable "devops-bucket-saksures" {
  default = "storage-bucket-terraform"
}