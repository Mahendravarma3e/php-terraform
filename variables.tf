variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  default = "ami-023a307f3d27ea427"
}

variable "key_name" {
  default = "aws"
}

variable "root_volume_size" {
  description = "The size of the root volume (in GB) for the EC2 instance"
  default     = 15
}

