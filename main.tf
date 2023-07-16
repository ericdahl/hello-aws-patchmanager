provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Name = local.name
    }
  }
}

locals {
  name = "hello-aws-patchmanager"
}

resource "aws_ssm_association" "inventory" {
  name = "AWS-GatherSoftwareInventory"
  targets {
    key    = "InstanceIds"
    values = ["*"]
  }
  parameters = {
    applications                = "Enabled"
    awsComponents               = "Enabled"
    customInventory             = "Enabled"
    instanceDetailedInformation = "Enabled"
    networkConfig               = "Enabled"
    services                    = "Enabled"
    windowsRoles                = "Enabled"
    windowsUpdates              = "Enabled"
  }
  schedule_expression = "rate(30 minutes)"
}

#resource "patch" "" {}

data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}


resource "aws_instance" "current" {

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.default.id]
  instance_type          = "t3a.micro"
  ami                    = data.aws_ssm_parameter.amazon_linux_2.value

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  tags = {
    Name = "current"
  }


}

resource "aws_instance" "outdated_20210721" {

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.default.id]
  instance_type          = "t3a.micro"
  ami                    = "ami-0c2b8ca1dad447f8a"
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  tags = {
    Name = "outdated-20210721"
  }


}



