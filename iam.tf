#######################-Create IAM Role-#######################
resource "aws_iam_role" "cloud_storage_iam_role_1" {
  name = "${var.project}-SSMRole-1"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#######################-Add S3 Permission-#######################
resource "aws_iam_role_policy_attachment" "cloud_storage_CW_policy" {
  role       = aws_iam_role.cloud_storage_iam_role_1.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

#######################--Create IAM Instance Profile-#######################-
resource "aws_iam_instance_profile" "e_instance_profile_1" {
  name = "cloud_storage-InstanceProfile1"
  role = aws_iam_role.cloud_storage_iam_role_1.name
}
