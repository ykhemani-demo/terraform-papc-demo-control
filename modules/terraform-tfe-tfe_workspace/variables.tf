variable "organization" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) organization. "
}

variable "project_id" {
  type        = string
  description = "(HCP) Terraform (Enterprise) project id."
}

variable "workspace" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) workspace."
}

variable "allow_destroy_plan" {
  type        = bool
  description = "Whether destroy plans can be queued on the workspace."
  default     = true
}

variable "assessments_enabled" {
  type        = bool
  description = "Whether to regularly run health assessments such as drift detection on the workspace."
  default     = true
}

variable "auto_apply" {
  type        = bool
  description = "Whether to automatically apply changes when a Terraform plan is successful."
  default     = true
}

variable "auto_destroy_activity_duration" {
  type        = string
  description = "A duration string of the period of time after workspace activity to automatically schedule an auto-destroy run. Must be of the form <number><unit> where allowed unit values are d and h."
  default     = null
}

variable "description" {
  type        = string
  description = "A description for the workspace."
  default     = null
}

variable "vcs_repo_identifier" {
  type        = string
  description = "A reference to your VCS repository in the format <vcs organization>/<repository> where <vcs organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is <ado organization>/<ado project>/_git/<ado repository>."
}

variable "vcs_repo_branch" {
  type        = string
  description = "The repository branch that Terraform will execute from. This defaults to the repository's default branch (e.g. main)."
  default     = null
}

variable "oauth_token_id" {
  type        = string
  description = "OAuth token id for VCS provider."
}

variable "hcp_run_task_id" {
  type = string
  description = "HCP Run Task ID."
}

variable "tfe_team_id" {
  type = string
  description = "ID of team to be given access to this workspace."
}

variable "tfe_team_access" {
  type = string
  description = "Access to be granted to TFE Team identified by var.tfe_team_id."
  default = "admin"
}

variable "slack_webhook_url" {
  type = string
  description = "Slack notification URL."
}
