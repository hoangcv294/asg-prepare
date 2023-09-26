####################-Create Private Server-#######################
resource "aws_instance" "apache_server" {
  ami                    = "ami-070beac973323ac97" 
  instance_type          = "t2.micro"              
  key_name               = "Server"                
  vpc_security_group_ids = [aws_security_group.private_server_sg.id]
  subnet_id              = aws_subnet.public_subnet_a.id
  iam_instance_profile   = aws_iam_instance_profile.e_instance_profile_1.name
  tags = {
    Name = "${var.project}-Server"
  }
}
