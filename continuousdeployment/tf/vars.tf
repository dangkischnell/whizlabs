#Batch1VPC4
variable "vpc_id" {
    default = "vpc-f36df88e"
}

variable "pub_subnets" {
    default = ["subnet-7cc8b11a"]
}

variable "ami_id" {
  type        = string
  default     = "ami-0d0a2c989446e6699"
}

variable "security_groups" {
    default = [ "sg-750e0071" ]
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
