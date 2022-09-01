### Define Variables

variable "samrdaymond_wa_ngw_a" {
  
}

### Define Resources

### EIP's for gateways

resource "aws_eip" "samrdaymond_wa_eip_a" {
  tags = {
    "name" : "samrdaymond_wa_eip_a"
  }
  
}

resource "aws_eip" "samrdaymond_wa_eip_b" {
  tags = {
    "name" : "samrdaymond_wa_eip_b"
  }
  
}

resource "aws_eip" "samrdaymond_wa_eip_c" {
  tags = {
    "name" : "samrdaymond_wa_eip_c"
  }
  
}

### Nat gateways
resource "aws_nat_gateway" "samrdaymond_wa_ngw_a" {
    allocation_id = aws_eip.samrdaymond_wa_eip_a.id
    subnet_id = aws_subnet.samrdaymond_wa_public_sub_a.id

    tags = {
      "key" = "value"
    }
  depends_on = [
    aws_internet_gateway.var.samrdaymond_wa_igw
  ]
}

resource "aws_nat_gateway" "samrdaymond_wa_ngw_b" {
    allocation_id = aws_eip.samrdaymond_wa_eip_b
    subnet_id = aws_subnet.samrdaymond_wa_public_sub_b.id

    tags = {
      "key" = "value"
    }
  depends_on = [
    aws_internet_gateway.var.samrdaymond_wa_igw
  ]
}

resource "aws_nat_gateway" "samrdaymond_wa_ngw_c" {
    allocation_id = aws_eip.samrdaymond_wa_eip_c
    subnet_id = aws_subnet.samrdaymond_wa_public_sub_c.id

    tags = {
      "key" = "value"
    }
  depends_on = [
    aws_internet_gateway.var.samrdaymond_wa_igw
  ]
}