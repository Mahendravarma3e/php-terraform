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

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "The master username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the database"
  type        = string
  default     = "35!O,|47_s3*"
}


