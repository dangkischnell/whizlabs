#Batch1VPC4
variable "access_key" {
    default = ""
}
variable "secret_key" {
    default = ""
}

variable "vpc_id" {
    default = "vpc-3a00c75c"
}

variable "pub_subnets" {
    default = ["subnet-cfca61a9"]
}

variable "ami_id" {
  type        = string
  default     = "ami-01a2825a801771f57"
}

variable "security_groups" {
    default = [ "sg-5bf26c11" ]
}

variable "desired_capacity" {
    default = 2
}

variable "min_capacity" {
    default = 1
}

variable "max_size" {
    default = 3
}
