resource "aws_iam_role" "SSMAutomationPackerRole" {
  name = "SSMAutomationPackerCF"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = ["ec2.amazonaws.com", "ssm.amazonaws.com"]
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
  ]
}

resource "aws_iam_policy" "SSMAutomationPackerInlinePolicy" {
  name = "SSMAutomationPackerInline"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:GetInstanceProfile",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "s3:ListBucket",
          "s3:GetObject",
          "ec2:DescribeInstances",
          "ec2:CreateKeyPair",
          "ec2:DescribeRegions",
          "ec2:DescribeVolumes",
          "ec2:DescribeSubnets",
          "ec2:DeleteKeyPair",
          "ec2:DescribeSecurityGroups"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "SSMAutomationPackerPassrolePolicy" {
  name = "SSMAutomationPackerPassrole"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "SSMAutomationPackerPassrolePolicy",
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = "${aws_iam_role.SSMAutomationPackerRole.arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "SSMAutomationPackerInlinePolicyAttachment" {
  role       = aws_iam_role.SSMAutomationPackerRole.name
  policy_arn = aws_iam_policy.SSMAutomationPackerInlinePolicy.arn
}

resource "aws_iam_role_policy_attachment" "SSMAutomationPackerPassrolePolicyAttachment" {
  role       = aws_iam_role.SSMAutomationPackerRole.name
  policy_arn = aws_iam_policy.SSMAutomationPackerPassrolePolicy.arn
}

resource "aws_iam_instance_profile" "SSMAutomationPackerInstanceProfile" {
  name = "SSMAutomationPackerCF"
  role = aws_iam_role.SSMAutomationPackerRole.name
}
