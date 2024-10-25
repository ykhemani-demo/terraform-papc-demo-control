variable "tfe_organization" {
  type        = string
  description = "Name of (HCP) Terraform (Enterprise) organization."
}

variable "policy_set_repo_identifier" {
  type        = string
  description = "A reference to your VCS repository in the format <vcs organization>/<repository> where <vcs organization> and <repository> refer to the organization and repository in your VCS provider."
}

variable "policy_set_repo_branch" {
  type        = string
  description = "The repository branch that Terraform will execute from."
  default     = "main"
}

variable "policy_set_name" {
  type        = string
  description = "Name of the policy set."
}

variable "policy_set_kind" {
  type        = string
  description = "The policy-as-code framework associated with the policy. Defaults to sentinel if not provided. Valid values are sentinel and opa. A policy set can only have policies that have the same underlying kind."
  default     = "sentinel"
}

variable "policies_path" {
  type        = string
  description = "The sub-path within the attached VCS repository to ingress when using vcs_repo. All files and directories outside of this sub-path will be ignored."
}

variable "global" {
  type        = bool
  description = "Whether or not policies in this set will apply to all workspaces. Defaults to false."
  default     = false
}

variable "oauth_token_id" {
  type        = string
  description = "VCS OAuth Token ID"
}