variable "vcs_repo_name" {
  type        = string
  description = "The name of the repository."
}

variable "repo_visibility" {
  type        = string
  description = "Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal. The visibility parameter overrides the private parameter."
  default     = "private"
}

