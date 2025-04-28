resource "aws_cloudwatch_metric_alarm" "ec2_idle_alarm" {
  alarm_name          = "ec2-idle-stop"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 900 # 15分
  statistic           = "Average"
  threshold           = 5
  alarm_actions       = [aws_cloudwatch_event_rule.ec2_stop_rule.arn]
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
}