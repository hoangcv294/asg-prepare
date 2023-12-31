#######################-Create SG Server-#######################
resource "aws_security_group" "private_server_sg" {
  name        = "${var.project}-Server"
  description = "Allow BH-ALB"

  vpc_id = aws_vpc.cloud_storage_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Security"
  }
}

#######################-Create SG ALB-#######################
resource "aws_security_group" "cloud_storage_sg" {
  name        = "${var.project}-SG"
  description = "All Traffic"

  vpc_id = aws_vpc.cloud_storage_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-SG"
  }
}