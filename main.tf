resource "aws_codedeploy_app" "main" {
  compute_platform = "Server"
  name             = local.name
}

resource "aws_codedeploy_deployment_config" "main" {
  deployment_config_name = local.name
  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name              = aws_codedeploy_app.main.name
  deployment_group_name = local.name

  service_role_arn = aws_iam_role.main.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Environment"
      type  = "KEY_AND_VALUE"
      value = "dev"
    }

    ec2_tag_filter {
      key   = "Workload"
      type  = "KEY_AND_VALUE"
      value = "workload-foo"
    }
  }

  /*
  trigger_configuration {
    trigger_events     = ["DeploymentFailure"]
    trigger_name       = "example-trigger"
    trigger_target_arn = aws_sns_topic.example.arn
  }
  */

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  /*
  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }
  */
}
