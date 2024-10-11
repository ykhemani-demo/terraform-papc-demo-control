variable "prefix" {
  type        = string
  description = "Naming prefix."
}

variable "tfe_organization" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) organization."
}

variable "tfe_project" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) project."
}

variable "tfe_team" {
  type        = string
  description = "Name of the team."
}

variable "vcs_owner" {
  type        = string
  description = "Name of VCS owner/organization."
}

variable "vcs_repo_name" {
  type        = string
  description = "Name of VCS repo."
}

variable "github_personal_access_token" {
  type        = string
  description = "GitHub personal access token authorized for (HCP) Terraform (Enterprise) VCS provider use."
  sensitive   = true
}

variable "run_task_hcp_url" {
  type        = string
  description = "URL for HCP Run Task."
}

variable "run_task_hcp_hmac_key" {
  type        = string
  description = "HMAC key for HCP Run Task."
  sensitive   = true
}

variable "slack_webhook_url" {
  type        = string
  description = "Slack app webhook URL for sending notifications."
}

variable "hcp_client_id" {
  type        = string
  description = "HCP Client ID for Service Principal with Viewer Role assigned in the HCP Project with your Packer Registry (Contributor Role if you want to allow use of latest channel)."
}

variable "hcp_client_secret" {
  type        = string
  description = "HCP Client Secert for Service Principal with Viewer Role assigned in the HCP Project with your Packer Registry (Contributor Role if you want to allow use of latest channel)."
  sensitive   = true
}

variable "hcp_packer_image_bucket_name" {
  type        = string
  description = "The slug of the HCP Packer Registry image bucket to pull from."
}

variable "hcp_packer_image_channel" {
  type        = string
  description = "The channel that points to the version of the image you want."
}
