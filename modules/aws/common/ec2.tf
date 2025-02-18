locals {
  ami_id = "ami-0d03c6e00d5732e28" # Amazon Linux 2023
}

# ------------------------------------------------------
# EC2 ML Server
# ------------------------------------------------------
/*
resource "aws_instance" "ml01" {
  ami = local.ami_id
  instance_type = "t3.micro" # 
  private_ip = "10.0.2.1"
  subnet_id = aws_subnet.private01.id
  vpc_security_group_ids = [ aws_security_group.sg01.id ]
  
  tags = {
    Name = "${var.name}-ml01"
  }

  user_data = ""
}
*/
