# Control Workspace

This Terraform configuration provisions resources for demonstrating the (HCP) [Terraform](https://terraform.io) (Enterprise) - [Prisma Cloud](https://www.paloaltonetworks.com/prisma/cloud) [Run Task](https://docs.prismacloud.io/en/enterprise-edition/content-collections/application-security/get-started/connect-code-and-build-providers/ci-cd-runs/add-terraform-run-tasks) integration.

The Prisma Cloud Run Task integration with HCP Terraform embeds Prisma Cloud's extensive library of pre-configured security policies into every workspace run. Prisma Cloud scans and enforces during the terraform plan stage, reporting results back to both HCP Terraform and Prisma Cloud.

Run tasks are driven by event hooks, which allow Prisma Cloud to receive information about each workspace run, and act upon this information by enforcing policies at build-time. Prisma Cloud can be configured to perform a scan at either the pre-plan or post-plan stage for a given workspace.

## Usage

You can run this Terraform configuration from (HCP) Terraform (Enterprise) or using the Terraform CLI.

### Prerequisites
In order to run this Terraform configuration, you must have:
* An HCP Terraform organization or Terraform Enterprise with support for Teams and Run Tasks.
* Admin access to the Terraform organization.
* A GitHub.com account.
* Admin access to Prisma Cloud.

### Terraform Graph
![Terraform Graph](graph.png?raw=true)

### Demo Environment
![Demo Environment](control.png?raw=true)

### Required Inputs
Please see [terraform.tfvars.example](terraform.tfvars.example) for sample inputs.

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.3 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.58.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_github-branch-dev"></a> [github-branch-dev](#module\_github-branch-dev) | ./modules/terraform-github-branch | n/a |
| <a name="module_github-branch-prod"></a> [github-branch-prod](#module\_github-branch-prod) | ./modules/terraform-github-branch | n/a |
| <a name="module_github-branch-stage"></a> [github-branch-stage](#module\_github-branch-stage) | ./modules/terraform-github-branch | n/a |
| <a name="module_github-repo"></a> [github-repo](#module\_github-repo) | ./modules/terraform-github-repo | n/a |
| <a name="module_oauth_client"></a> [oauth\_client](#module\_oauth\_client) | ./modules/terraform-tfe-tfe_oauth_client | n/a |
| <a name="module_project"></a> [project](#module\_project) | ./modules/terraform-tfe-tfe_project | n/a |
| <a name="module_workspace-dev"></a> [workspace-dev](#module\_workspace-dev) | ./modules/terraform-tfe-tfe_workspace | n/a |
| <a name="module_workspace-prod"></a> [workspace-prod](#module\_workspace-prod) | ./modules/terraform-tfe-tfe_workspace | n/a |
| <a name="module_workspace-stage"></a> [workspace-stage](#module\_workspace-stage) | ./modules/terraform-tfe-tfe_workspace | n/a |

## Resources

| Name | Type |
|------|------|
| [tfe_organization_run_task.hcp](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_run_task) | resource |
| [tfe_team.team](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team_access.team_access_dev](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.team_access_prod](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.team_access_stage](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_token.team_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_personal_access_token"></a> [github\_personal\_access\_token](#input\_github\_personal\_access\_token) | GitHub personal access token authorized for (HCP) Terraform (Enterprise) VCS provider use. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Naming prefix. | `string` | n/a | yes |
| <a name="input_run_task_hcp_hmac_key"></a> [run\_task\_hcp\_hmac\_key](#input\_run\_task\_hcp\_hmac\_key) | HMAC key for HCP Run Task. | `string` | n/a | yes |
| <a name="input_run_task_hcp_url"></a> [run\_task\_hcp\_url](#input\_run\_task\_hcp\_url) | URL for HCP Run Task. | `string` | n/a | yes |
| <a name="input_tfe_organization"></a> [tfe\_organization](#input\_tfe\_organization) | Name of (HCP) Terraform (Enterprise) organization. | `string` | n/a | yes |
| <a name="input_tfe_project"></a> [tfe\_project](#input\_tfe\_project) | Name of (HCP) Terraform (Enterprise) project. | `string` | n/a | yes |
| <a name="input_tfe_team"></a> [tfe\_team](#input\_tfe\_team) | Name of the team. | `string` | n/a | yes |
| <a name="input_vcs_owner"></a> [vcs\_owner](#input\_vcs\_owner) | Name of VCS owner/organization. | `string` | n/a | yes |
| <a name="input_vcs_repo_name"></a> [vcs\_repo\_name](#input\_vcs\_repo\_name) | Name of VCS repo. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_html_url"></a> [repo\_html\_url](#output\_repo\_html\_url) | n/a |
| <a name="output_repo_http_clone_url"></a> [repo\_http\_clone\_url](#output\_repo\_http\_clone\_url) | n/a |
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | n/a |
| <a name="output_repo_ssh_clone_url"></a> [repo\_ssh\_clone\_url](#output\_repo\_ssh\_clone\_url) | n/a |
| <a name="output_tfe_team_token"></a> [tfe\_team\_token](#output\_tfe\_team\_token) | n/a |
<!-- END_TF_DOCS -->

---

## Reference:

* [Terraform: Integration guide for Prisma Cloud by Palo Alto Networks](https://developer.hashicorp.com/validated-designs/integration-patterns-guides-terraform-palo-alto-prisma-cloud-integration)
* [HCP Terraform – Prisma Cloud Run Task Integration](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs)
* [tfe Provider Docimentation](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)
* [GitHub Provider Documentation](https://registry.terraform.io/providers/integrations/github/latest/docs)
* [Securing Golden Images at Build Using Prisma Cloud](https://www.paloaltonetworks.com/blog/prisma-cloud/securing-golden-images-hashicorp-packer/)
---
