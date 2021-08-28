#Batch1VPC4
variable "vpc_id" {
    default = "vpc-3a00c75c"
}

variable "pub_subnets" {
    default = ["subnet-cfca61a9"]
}

variable "ami_id" {
  type        = string
  default     = "ami-0772503ce7123061b"
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
