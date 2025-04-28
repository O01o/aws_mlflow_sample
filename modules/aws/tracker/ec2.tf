# IAMロールの作成
resource "aws_iam_role" "mlflow_tracker_ec2_role" {
  name = "MLWorkflowEC2Role"

  assume_role_policy = file("${path.module}/data/ec2_iam_ml_role.json")
}

# IAMポリシーのアタッチ
resource "aws_iam_role_policy" "mlflow_tracker_ec2_policy" {
  name   = "MLWorkflowEC2Policy"
  role   = aws_iam_role.mlflow_tracker_ec2_role.id
  policy = templatefile("${path.module}/data/ec2_iam_ml_policy.json", {})
}

resource "aws_iam_instance_profile" "mlflow_tracker_instance_profile" {
  name = "mlflow-tracker-instance-profile"
  role = aws_iam_role.mlflow_tracker_ec2_role.name
}

resource "aws_instance" "mlflow_tracker" {
  ami           = "ami-0fb04413c9de69305" # Replace with Amazon Linux 2 AMI ID
  instance_type = "t3.small"
  subnet_id     = var.subnet_id
  key_name      = var.key_pair_name

  iam_instance_profile = aws_iam_instance_profile.mlflow_tracker_instance_profile.name
  vpc_security_group_ids      = [aws_security_group.mlflow_tracker_sg.id]

  user_data = templatefile("${path.module}/data/ec2_user_data.sh", {
  })

  tags = {
    Name = "MLflowTrackerInstance"
  }
}
