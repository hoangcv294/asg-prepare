resource "aws_launch_configuration" "lc_app" {
  name = "${var.project}-Server"
  image_id      = "ami-070beac973323ac97"
  instance_type = "t2.micro"
  security_groups  = [aws_security_group.private_server_sg.id]
  key_name = "Server" 
  associate_public_ip_address = true
}



resource "aws_autoscaling_group" "asg_app" {
  name = "asg-app"
  launch_configuration = aws_launch_configuration.lc_app.name
  min_size             = 1
  desired_capacity     = 1
  max_size             = 2 
  vpc_zone_identifier = [aws_subnet.public_subnet_a.id , aws_subnet.public_subnet_b.id]  
  target_group_arns = [aws_lb_target_group.cloud_storage_tg.arn]
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name = "scale-up-policy"
  policy_type        = "SimpleScaling"
  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown           = 300
  autoscaling_group_name = aws_autoscaling_group.asg_app.name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name = "scale-down-policy"
  policy_type        = "SimpleScaling"
  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown           = 300
  autoscaling_group_name = aws_autoscaling_group.asg_app.name
}
