resource "aws_cloudwatch_event_rule" "ec2_stop_rule" {
  name        = "ec2-stop-rule"
  event_pattern = templatefile("${path.module}/data/eventbridge_pattern.json", {})
}

resource "aws_cloudwatch_event_target" "ec2_stop_target" {
  rule      = aws_cloudwatch_event_rule.ec2_stop_rule.name
  arn       = aws_sfn_state_machine.ec2_stop_state_machine.arn
  role_arn  = aws_iam_role.sfn_execution_role.arn
}