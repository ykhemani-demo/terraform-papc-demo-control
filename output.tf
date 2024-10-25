output "tfe_team_token" {
  value       = tfe_team_token.team_token.token
  sensitive   = true
  description = "Terraform Team Token. Use this when configuring the Run Task in Prisma Cloud."
}

output "app_repo_html_url" {
  value       = module.github-repo-app.html_url
  description = "URL for the GitHub repository for our demo app."
}

output "app_repo_http_clone_url" {
  value       = module.github-repo-app.http_clone_url
  description = "URL that can be provided to clone the repository for our demo app via HTTPS."
}

output "repo_ssh_clone_url" {
  value       = module.github-repo-app.ssh_clone_url
  description = "URL that can be provided to clone the repository for our demo app via SSH."
}

output "repo_name" {
  value       = module.github-repo-app.full_name
  description = "Full name of the GitHub repository for our demo app."
}

output "workspace-dev-url" {
  value       = module.workspace-dev.workspace_url
  description = "Development Workspace URL."
}

output "workspace-stage-url" {
  value       = module.workspace-stage.workspace_url
  description = "Staging Workspace URL."
}

output "workspace-prod-url" {
  value       = module.workspace-prod.workspace_url
  description = "Production Workspace URL."
}

output "tfe_agent_token" {
  value     = tfe_agent_token.agent_token[*]
  sensitive = true
}
