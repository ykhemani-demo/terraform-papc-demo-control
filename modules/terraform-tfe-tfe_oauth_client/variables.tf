variable "organization" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) organization."
}

variable "oauth_client_name" {
  type        = string
  description = "Display name for the OAuth Client."
  default     = null
}

variable "oauth_client_api_url" {
  type        = string
  description = "The base URL of your VCS provider's API."
  default     = "https://api.github.com"
}

variable "oauth_client_http_url" {
  type        = string
  description = "The homepage of your VCS provider."
  default     = "https://github.com"
}

variable "oauth_client_service_provider" {
  type        = string
  description = "The VCS provider being connected with. Valid options are ado_server, ado_services, bitbucket_data_center, bitbucket_hosted, bitbucket_server(deprecated), github, github_enterprise, gitlab_hosted, gitlab_community_edition, or gitlab_enterprise_edition."
  default     = "github"
}

variable "github_personal_access_token" {
  type        = string
  description = "GitHub personal access token authorized for (HCP) Terraform (Enterprise) VCS provider use."
  sensitive   = true
}

