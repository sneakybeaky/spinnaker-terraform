resource "aws_iam_user" "spinnaker_user_account" {
    name = "my-aws-account"
}

resource "aws_key_pair" "my-aws-account-keypair" {
  key_name = "my-aws-account-keypair"
  public_key = "${var.my-aws-account-public-key}"
}


resource "aws_iam_role_policy" "spinnaker_policy" {
    name = "spinnaker_policy"
    role = "${aws_iam_role.spinnaker_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
       "Action": [
            "iam:PassRole"
        ],
        "Resource": [
            "*"
        ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "spinnaker_role" {
    name = "spinnaker_role"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "spinnaker_base_iam_role" {
    name = "base_iam_role"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "base_iam_profile" {
    name = "BaseIAMRole"
    roles = ["${aws_iam_role.spinnaker_base_iam_role.name}"]
}



resource "aws_iam_policy_attachment" "spinnaker-attach" {
    name = "spinnaker-attachment"
    roles = ["${aws_iam_role.spinnaker_role.name}"]
    policy_arn = "${aws_iam_policy.power_user_access.arn}"
}

resource "aws_iam_instance_profile" "spinnaker" {
    name = "spinnaker_profile"
    roles = ["${aws_iam_role.spinnaker_role.name}"]
}

resource "aws_iam_policy" "power_user_access" {
    name = "power_user_access"
    description = "Replicates the AWS power user policy"
    policy =  <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "NotAction": "iam:*",
      "Resource": "*"
    }
  ]
}
EOF
}