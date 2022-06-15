#================== Data ================

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "permissions" {
  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeInstanceStatus",
      "ssm:*",
      "ec2messages:*",
      "s3:*",
      "sqs:*"
    ]
    resources = ["*"]
  }
}

#================== Create instance profile ================

resource "aws_iam_instance_profile" "ec2_eb_profile" {
  name_prefix = "${var.env}-eb-profile-"
  role        = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name_prefix        = "${var.env}-eb-instance-"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
    "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier",
    "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  ]

  inline_policy {
    name   = "eb-application-permissions"
    policy = data.aws_iam_policy_document.permissions.json
  }
}

#================== Create eb app ================

resource "aws_elastic_beanstalk_application" "example" {
  name        = "${var.env}-app"
  description = "${var.env}-desc-app"
}

resource "aws_elastic_beanstalk_environment" "eb_env" {
  name         = "${var.env}-env"
  application  = aws_elastic_beanstalk_application.example.name
  platform_arn = var.arn_platform
  tags         = merge(var.common_tags, { env = var.env })

  #================== Autoscaling group ================

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.ec2_eb_profile.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.key_for_instance
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.min_size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.max_size
  }

  #================== LoadBalancer ================

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = var.type_lb
  }

  #================== Network ================

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", sort(var.application_subnets))
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = var.elb_scheme
  }

  #================== Rolling updates and deployments ================

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = var.update_type
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = var.deployment_type
  }

  #================== Scalling triggers ================

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = var.scalling_type
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = var.statistic
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = var.unit
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = var.lower_threshold
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = var.upper_threshold
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Period"
    value     = var.period_scalling
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "BreachDuration"
    value     = var.breach_duration
  }

  #================== Add env on servers ================

  dynamic "setting" {
    for_each = var.environment_variables_map
    content {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = setting.key
      value     = setting.value
    }
  }
}
