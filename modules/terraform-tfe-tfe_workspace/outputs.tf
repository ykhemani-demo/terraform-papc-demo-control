output "workspace_id" {
  value = tfe_workspace.workspace.id
}

output "workspace_url" {
  value = tfe_workspace.workspace.html_url
}

output "workspace_name" {
  value = tfe_workspace.workspace.name
}
