### Define Variables
variable "igw_name" {
    type = string
    default = "samrdaymond_wa_igw"
  
}

### Define Resources

resource "aws_internet_gateway" "var.igw_name" {
  vpc_id = aws_vpc.var.vpc_name.id

  tags = {
    Name = "var.igw_name"
  }
}