# IAMロールの作成
resource "aws_iam_role" "ml_sample_ec2_role" {
  name = "MLSampleEC2Role"

  assume_role_policy = file("${path.module}/data/ec2_iam_ml_role.json")
}

# IAMポリシーのアタッチ
resource "aws_iam_role_policy" "ml_sample_ec2_policy" {
  name   = "MLSampleEC2Policy"
  role   = aws_iam_role.ml_sample_ec2_role.id
  policy = templatefile("${path.module}/data/ec2_iam_ml_policy.json", {
    bucket_arn = var.bucket_arn
  })
}

resource "aws_iam_instance_profile" "ml_sample_instance_profile" {
  name = "ml-sample-instance-profile"
  role = aws_iam_role.ml_sample_ec2_role.name
}

/*
resource "aws_key_pair" "key_pair" {
  
}
*/

resource "aws_instance" "ml_sample" {
  ami           = "ami-039dceec5b6e8d729" # # Deep Learning OSS Nvidia Driver AMI GPU PyTorch 2.5 (Amazon Linux 2023)
  instance_type = "g4dn.xlarge"
  subnet_id     = var.subnet_id
  # key_name      = aws_key_pair.key_pair.key_name

  iam_instance_profile = aws_iam_instance_profile.ml_sample_instance_profile.name
  vpc_security_group_ids      = [aws_security_group.ml_sample_sg.id]

  user_data = templatefile("${path.module}/data/ec2_user_data.sh", {
  })

  tags = {
    Name = "MLSampleInstance"
  }
}