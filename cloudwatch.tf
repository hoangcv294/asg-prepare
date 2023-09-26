resource "aws_cloudwatch_metric_alarm" "high_ram_alarm" {
  alarm_name          = "high-ram-usage-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name         = "MemoryUtilization"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "Alarm when RAM usage is high"
  alarm_actions       = [aws_autoscaling_policy.scale_up_policy.arn]

  dimensions = {
    InstanceId = aws_instance.apache_server.id
  }
}

resource "aws_cloudwatch_metric_alarm" "low_ram_alarm" {
  alarm_name          = "low-ram-usage-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name         = "MemoryUtilization"
  namespace           = "CWAgent"
  period              = 300
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Alarm when RAM usage is low"
  alarm_actions       = [aws_autoscaling_policy.scale_down_policy.arn]

  dimensions = {
    InstanceId = aws_instance.apache_server.id
  }
}
