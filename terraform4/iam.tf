data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rackula_ssm" {
  name               = "tf-rackula-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = { Name = "tf-rackula-ssm-role" }
}

resource "aws_iam_role_policy_attachment" "rackula_ssm" {
  role       = aws_iam_role.rackula_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "rackula_ssm" {
  name = "tf-rackula-ssm-profile"
  role = aws_iam_role.rackula_ssm.name
}
