#variable for name of the vpc
variable "vpc_name" {
  default     = "samrdaymond_wa_vpc"
}

    
#variable for VPC cidr block
variable "vpc_cidr" {
    default = "10.0.0.0/24"
}

#variable for each availability zone

variable "availability_zone" {
  type = map 
    default = {
      "aza" = "ap-southeast-2a"
      "azb" = "ap-southeast-2b"
      "azc" = "ap-southeast-2c"
    }
}

#create variable for each subnet cidr block

variable "private_subnet_cidr" {
  type = map
  default = {
    "sub_a" = "10.0.0.0/26"
    "sub_b" = "10.0.0.64/26"
    "sub_c" = "10.0.0.128/26"
  }
  
}

variable "public_subnet_cidr" {
  type = map
  default = {
    "sub_a" = "10.0.0.192/28"
    "sub_b" = "10.0.0.208/28"
    "sub_c" = "10.0.0.224/28"
  }
  
}

#variable for cidr block for ssh into public sg 

variable "ingress_CIDR_block_pub" {
  default = "159.196.65.9"
}

#variable for internet gateway name
variable "igw_name" {
  default = "samrdaymond_wa_igw"
  
}
