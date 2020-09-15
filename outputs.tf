output "app_name" {
  description = "CodeDeploy Application Name"
  value       = aws_codedeploy_app.main.name
}
