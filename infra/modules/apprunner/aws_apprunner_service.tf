# App Runnerサービス
resource "aws_apprunner_service" "nginx_service" {
  service_name = "nginx-service"

  source_configuration {
    authentication_configuration {
      access_role_arn = var.iam_role_app_runner_arn
    }

    image_repository {
      image_identifier      = "${var.web_repository_url}:latest"
      image_repository_type = "ECR"

      image_configuration {
        port = "80"
        runtime_environment_variables = {
          "NGINX_ENTRYPOINT_QUIET_LOGS" = "1"
        }
      }
    }

    auto_deployments_enabled = true
  }

  health_check_configuration {
    path = "/health"
  }
}
