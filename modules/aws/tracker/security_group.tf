resource "aws_security_group" "mlflow_tracker_sg" {
  name        = "mlflow-tracker-sg"
  description = "Security group for MLflow Tracker"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust as needed for SSH access restrictions
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"] # Restrict to localhost for port forwarding
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}