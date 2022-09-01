### Define Variables
variable "vpc_name" {
  default     = "samrdaymond_wa_vpc"
}


#variable for VPC cidr block
variable "vpc_cidr" {
    default = "10.0.0.0/24"
}

#variable for each availability zone

variable "availability_zone" {
  type = "map" 
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

### Create Resources

# vpc creation
resource "aws_vpc" "var.vpc_name" {
    cidr_block = var.vpc_cidr
}
#end resource

#3 private subnet creations
resource "aws_subnet" "samrdaymond_wa_private_sub_a" {
  vpc_id = aws_vpc.var.vpc_name.id
  cidr_block = var.private_subnet_cidr.sub_a
  availability_zone = var.availability_zone.aza

  tags = {
    "name" = "private_sub_a"
    "zone" = "private"
  }
}

resource "aws_subnet" "samrdaymond_wa_private_sub_b" {
  vpc_id = aws_vpc.var.vpc_name.id
  cidr_block = var.private_subnet_cidr.sub_b
  availability_zone = var.availability_zone.azb

  tags = {
    "name" = "private_sub_b"
    "zone" = "private"
  }
}

resource "aws_subnet" "samrdaymond_wa_private_sub_c" {
  vpc_id = aws_vpc.var.vpc_name.id
  cidr_block = vvar.private_subnet_cidr.sub_c
  availability_zone = var.availability_zone.aza

  tags = {
    "name" = "private_sub_c"
    "zone" = "private"
  }
}
#end resource

#security group creation for private subnets

resource "aws_security_group" "samrdaymond_wa_private_sg" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_private_sg"
  description = "security group for private subnets"

  ingress = [ {
    description = "allow access from security group public"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [ "${aws_security_group.samrdaymond_wa_public_sg}" ]
  }
  egress = [ {
    description = "allow egress to anywhere"
    from_port = 0
    to_port = 0
    protocol = "-1"
]
}

#creation of route tables for private subnets

resource = "aws_route" "samrdaymond_wa_private_rt_a" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_private_rt_a"
}
resource = "aws_route" "samrdaymond_wa_private_rt_b" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_private_rt_a"
}
resource = "aws_route" "samrdaymond_wa_private_rt_c" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_private_rt_a"
}

#routes for private subnets to NGW's
resource "aws_route" "samrdaymond_wa_private_a_dr" {
  route_table_id = "aws_route_table.samrdaymond_wa_public_rt_a"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_nat_gateway.samrdaymond_ngw_a"
}
resource "aws_route" "samrdaymond_wa_private_b_dr" {
  route_table_id = "aws_route_table.samrdaymond_wa_public_rt_b"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_nat_gateway.samrdaymond_ngw_b"
}
resource "aws_route" "samrdaymond_wa_private_c_dr" {
  route_table_id = "aws_route_table.samrdaymond_wa_public_rt_c"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_i_gateway.samrdaymond_ngw_c"
}

#associate route tables with respective private subnets

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.samrdaymond_wa_private_sub_a
  route_table_id = aws_route_table.samrdaymond_wa_private_rt_a.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.samrdaymond_wa_private_sub_b
  route_table_id = aws_route_table.samrdaymond_wa_private_rt_b.id

}resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.samrdaymond_wa_private_sub_c
  route_table_id = aws_route_table.samrdaymond_wa_private_rt_c.id
}

#3 public subnet creation
resource "aws_subnet" "samrdaymond_wa_public_sub_a" {
  vpc_id = aws_vpc.var.vpc_name.id
  cidr_block = var.public_sub_a_cid
  availability_zone = ap-southeast-2a

  tags = {
    "name" = "public_sub_a"
    "zone" = "public"
  }
}

resource "aws_subnet" "samrdaymond_wa_public_sub_b" {
  vpc_id = aws_vpc.var.vpc_name.id
  cidr_block = var.public_sub_b_cid
  availability_zone = ap-southeast-2b

  tags = {
    "name" = "public_sub_b"
    "zone" = "public"
  }
  
}
resource "aws_subnet" "samrdaymond_wa_public_sub_c" {
  vpc_id = aws_vpc.var.vpc_name.id
  cidr_block = var.public_sub_c_cid
  availability_zone = ap-southeast-2c

  tags = {
    "name" = "public_sub_c"
    "zone" = "public"
  }
  
}
#end resource

#creation of security group for public subnets"

resource "aws_security_group" "samrdaymond_wa_public_sg" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_public_sg"
  description = "security group for public subnets"

  ingress = [ {
    description = "allow access from security group private"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [ "${aws_security_group.samrdaymond_wa_private_sg}" ]
  }
  ingress = [ {
    description = "allow access from ssh anywhere"
    cidr_block = ["var.ingress_CIDR_block_pub"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }]
  egress = [ {
    description = "allow egress to anywhere"
    from_port = 0
    to_port = 0
    protocol = "-1"
    }
  ]
}

#creation of Route Tables for the public subnets

resource = "aws_route" "samrdaymond_wa_public_rt_a" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_public_rt_a"
}
resource = "aws_route" "samrdaymond_wa_public_rt_b" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_public_rt_a"
}
resource = "aws_route" "samrdaymond_wa_public_rt_c" {
  vpc_id = aws_vpc.var.vpc_name.id
  name = "samrdaymond_wa_public_rt_a"
}

#routes for public subnets to IGW
resource "aws_route" "samrdaymond_wa_private_a_dr" {
  route_table_id = "aws_route_table.samrdaymond_wa_public_rt_a"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_internet_gateway.samrdaymond_wa_igw"
}
resource "aws_route" "samrdaymond_wa_private_b_dr" {
  route_table_id = "aws_route_table.samrdaymond_wa_public_rt_b"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_internet_gateway.samrdaymond_wa_igw"
}
resource "aws_route" "samrdaymond_wa_private_c_dr" {
  route_table_id = "aws_route_table.samrdaymond_wa_public_rt_c"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "aws_internet_gateway.samrdaymond_wa_igw"
}

#associate route tables with respective public subnets

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.samrdaymond_wa_public_sub_a
  route_table_id = aws_route_table.samrdaymond_wa_public_rt_a.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.samrdaymond_wa_public_sub_b
  route_table_id = aws_route_table.samrdaymond_wa_public_rt_b.id

}resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.samrdaymond_wa_public_sub_c
  route_table_id = aws_route_table.samrdaymond_wa_public_rt_c.id
}


