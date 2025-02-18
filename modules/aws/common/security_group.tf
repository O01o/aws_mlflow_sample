# ------------------------------------------------------
# Security Group for EC2 ML Server
# ------------------------------------------------------

resource "aws_security_group" "sg01" {
  name = "${var.name}-sg01"
  description = "for ML Server"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-sg01"
  }
}
/*
resource "aws_vpc_security_group_ingress_rule" "sg01_http_allow" {
  security_group_id = aws_security_group.sg01.id
  # referenced_security_group_id = 
  description = ""
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}
*/
