resource "aws_ec2_instance_connect_endpoint" "eice" {
  subnet_id    = var.subnet_id
  security_group_ids = [aws_security_group.mlflow_tracker_sg.id]
  tags = {
    Name = "MLflowTrackerEndpoint"
  }
}