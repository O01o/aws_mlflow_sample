resource "aws_iam_role" "sfn_execution_role" {
  name = "sfn-ec2-stop-role"
  assume_role_policy = templatefile("${path.module}/data/sfn_iam_role.json", {})
}

resource "aws_iam_role_policy" "sfn_policy" {
  name   = "stop-ec2-policy"
  role   = aws_iam_role.sfn_execution_role.id
  policy = templatefile("${path.module}/data/sfn_iam_policy.json", {})
}

resource "aws_sfn_state_machine" "ec2_stop_state_machine" {
  name     = "ec2-stop-state-machine"
  role_arn = aws_iam_role.sfn_execution_role.arn
  definition = templatefile("${path.module}/data/sfn_definition.json", {})
}