# Control Workspace

This Terraform configuration provisions resources for demonstrating the (HCP) [Terraform](https://terraform.io) (Enterprise) - [Prisma Cloud](https://www.paloaltonetworks.com/prisma/cloud) [Run Task](https://docs.prismacloud.io/en/enterprise-edition/content-collections/application-security/get-started/connect-code-and-build-providers/ci-cd-runs/add-terraform-run-tasks) integration.

The Prisma Cloud Run Task integration with HCP Terraform embeds Prisma Cloud's extensive library of pre-configured security policies into every workspace run. Prisma Cloud scans and enforces during the terraform plan stage, reporting results back to both HCP Terraform and Prisma Cloud.

Run tasks are driven by event hooks, which allow Prisma Cloud to receive information about each workspace run, and act upon this information by enforcing policies at build-time. Prisma Cloud can be configured to perform a scan at either the pre-plan or post-plan stage for a given workspace.

We also configure the HCP Packer Run Task Integration. 

## Usage

You can run this Terraform configuration in (HCP) Terraform (Enterprise) or using the Terraform CLI.

### Prerequisites
In order to run this Terraform configuration, you must have:
* An HCP Terraform organization or Terraform Enterprise with support for Teams and Run Tasks. Use a separate organization for this demo environment to avoid conflicts.
* Admin access to the Terraform organization.
* A GitHub.com account.
* Admin access to Prisma Cloud.

### Demo Environment
![Demo Environment](control.png?raw=true)

### Terraform Graph
![Terraform Graph](graph.png?raw=true)

### Required Inputs
Please see [terraform.tfvars.example](terraform.tfvars.example) for sample inputs.

### Testing
This Terraform configuration has been tested with:
* Terraform 1.9.5
* tfe Provider 0.58.1
* GitHub Provider 6.3.0
* HCP Terraform organization with Plus entitlement
* Prisma Cloud Enterprise

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
| <a name="provider_github"></a> [github](#provider\_github) | 6.3.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.58.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_policy_set"></a> [aws\_policy\_set](#module\_aws\_policy\_set) | ./modules/terraform-tfe-tfe_policy_set | n/a |
| <a name="module_azure_policy_set"></a> [azure\_policy\_set](#module\_azure\_policy\_set) | ./modules/terraform-tfe-tfe_policy_set | n/a |
| <a name="module_cloud_agnostic_policy_set"></a> [cloud\_agnostic\_policy\_set](#module\_cloud\_agnostic\_policy\_set) | ./modules/terraform-tfe-tfe_policy_set | n/a |
| <a name="module_gcp_policy_set"></a> [gcp\_policy\_set](#module\_gcp\_policy\_set) | ./modules/terraform-tfe-tfe_policy_set | n/a |
| <a name="module_github-branch-dev"></a> [github-branch-dev](#module\_github-branch-dev) | ./modules/terraform-github-branch | n/a |
| <a name="module_github-branch-prod"></a> [github-branch-prod](#module\_github-branch-prod) | ./modules/terraform-github-branch | n/a |
| <a name="module_github-branch-stage"></a> [github-branch-stage](#module\_github-branch-stage) | ./modules/terraform-github-branch | n/a |
| <a name="module_github-repo-app"></a> [github-repo-app](#module\_github-repo-app) | ./modules/terraform-github-repo | n/a |
| <a name="module_github-repo-common"></a> [github-repo-common](#module\_github-repo-common) | ./modules/terraform-github-repo | n/a |
| <a name="module_hcp_variable_set"></a> [hcp\_variable\_set](#module\_hcp\_variable\_set) | flowingis/variable-set/tfe | 0.3.1 |
| <a name="module_oauth_client"></a> [oauth\_client](#module\_oauth\_client) | ./modules/terraform-tfe-tfe_oauth_client | n/a |
| <a name="module_papc_global_tags_variable_set"></a> [papc\_global\_tags\_variable\_set](#module\_papc\_global\_tags\_variable\_set) | flowingis/variable-set/tfe | 0.3.1 |
| <a name="module_project"></a> [project](#module\_project) | ./modules/terraform-tfe-tfe_project | n/a |
| <a name="module_variables-common"></a> [variables-common](#module\_variables-common) | app.terraform.io/ykhemani-demo-org/variable/tfe | 0.0.1 |
| <a name="module_variables-dev"></a> [variables-dev](#module\_variables-dev) | app.terraform.io/ykhemani-demo-org/variable/tfe | 0.0.1 |
| <a name="module_variables-prod"></a> [variables-prod](#module\_variables-prod) | app.terraform.io/ykhemani-demo-org/variable/tfe | 0.0.1 |
| <a name="module_variables-stage"></a> [variables-stage](#module\_variables-stage) | app.terraform.io/ykhemani-demo-org/variable/tfe | 0.0.1 |
| <a name="module_workspace-common"></a> [workspace-common](#module\_workspace-common) | ./modules/terraform-tfe-tfe_workspace | n/a |
| <a name="module_workspace-dev"></a> [workspace-dev](#module\_workspace-dev) | ./modules/terraform-tfe-tfe_workspace | n/a |
| <a name="module_workspace-prod"></a> [workspace-prod](#module\_workspace-prod) | ./modules/terraform-tfe-tfe_workspace | n/a |
| <a name="module_workspace-stage"></a> [workspace-stage](#module\_workspace-stage) | ./modules/terraform-tfe-tfe_workspace | n/a |

## Resources

| Name | Type |
|------|------|
| [github_repository_file.gitignore](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.gitignore-common](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.tf0](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.vpc](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [tfe_agent_pool.agent_pool](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/agent_pool) | resource |
| [tfe_agent_token.agent_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/agent_token) | resource |
| [tfe_organization_run_task.hcp](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization_run_task) | resource |
| [tfe_policy_set_parameter.cloud_agnostic-organizations](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set_parameter) | resource |
| [tfe_project_variable_set.hcp](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set) | resource |
| [tfe_project_variable_set.papc_global_tags](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set) | resource |
| [tfe_team.team](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team_token.team_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_personal_access_token"></a> [github\_personal\_access\_token](#input\_github\_personal\_access\_token) | GitHub personal access token authorized for (HCP) Terraform (Enterprise) VCS provider use. | `string` | n/a | yes |
| <a name="input_hcp_client_id"></a> [hcp\_client\_id](#input\_hcp\_client\_id) | HCP Client ID for Service Principal with Viewer Role assigned in the HCP Project with your Packer Registry (Contributor Role if you want to allow use of latest channel). | `string` | n/a | yes |
| <a name="input_hcp_client_secret"></a> [hcp\_client\_secret](#input\_hcp\_client\_secret) | HCP Client Secert for Service Principal with Viewer Role assigned in the HCP Project with your Packer Registry (Contributor Role if you want to allow use of latest channel). | `string` | n/a | yes |
| <a name="input_hcp_packer_image_bucket_name"></a> [hcp\_packer\_image\_bucket\_name](#input\_hcp\_packer\_image\_bucket\_name) | The slug of the HCP Packer Registry image bucket to pull from. | `string` | n/a | yes |
| <a name="input_hcp_packer_image_channel"></a> [hcp\_packer\_image\_channel](#input\_hcp\_packer\_image\_channel) | The channel that points to the version of the image you want. | `string` | n/a | yes |
| <a name="input_policy_set_repo_branch"></a> [policy\_set\_repo\_branch](#input\_policy\_set\_repo\_branch) | The repository branch that Terraform will execute from. | `string` | `"main"` | no |
| <a name="input_policy_set_repo_identifier"></a> [policy\_set\_repo\_identifier](#input\_policy\_set\_repo\_identifier) | A reference to your VCS repository in the format <vcs organization>/<repository> where <vcs organization> and <repository> refer to the organization and repository in your VCS provider. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Naming prefix. | `string` | n/a | yes |
| <a name="input_repo_description"></a> [repo\_description](#input\_repo\_description) | A description of the repository. | `string` | n/a | yes |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | Name of VCS repo. | `string` | n/a | yes |
| <a name="input_repo_visibility"></a> [repo\_visibility](#input\_repo\_visibility) | Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal. The visibility parameter overrides the private parameter. | `string` | `"private"` | no |
| <a name="input_run_task_hcp_hmac_key"></a> [run\_task\_hcp\_hmac\_key](#input\_run\_task\_hcp\_hmac\_key) | HMAC key for HCP Run Task. | `string` | n/a | yes |
| <a name="input_run_task_hcp_url"></a> [run\_task\_hcp\_url](#input\_run\_task\_hcp\_url) | URL for HCP Run Task. | `string` | n/a | yes |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | Slack app webhook URL for sending notifications. | `string` | n/a | yes |
| <a name="input_tfe_agent_organization_scoped"></a> [tfe\_agent\_organization\_scoped](#input\_tfe\_agent\_organization\_scoped) | Whether or not the agent pool is scoped to all workspaces in the organization. | `bool` | `true` | no |
| <a name="input_tfe_agent_pool_name"></a> [tfe\_agent\_pool\_name](#input\_tfe\_agent\_pool\_name) | Name of the agent pool to create. | `string` | `""` | no |
| <a name="input_tfe_organization"></a> [tfe\_organization](#input\_tfe\_organization) | Name of (HCP) Terraform (Enterprise) organization. | `string` | n/a | yes |
| <a name="input_tfe_project"></a> [tfe\_project](#input\_tfe\_project) | Name of (HCP) Terraform (Enterprise) project. | `string` | n/a | yes |
| <a name="input_tfe_team"></a> [tfe\_team](#input\_tfe\_team) | Name of the team. | `string` | n/a | yes |
| <a name="input_vcs_owner"></a> [vcs\_owner](#input\_vcs\_owner) | Name of VCS owner/organization. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_repo_html_url"></a> [app\_repo\_html\_url](#output\_app\_repo\_html\_url) | URL for the GitHub repository for our demo app. |
| <a name="output_app_repo_http_clone_url"></a> [app\_repo\_http\_clone\_url](#output\_app\_repo\_http\_clone\_url) | URL that can be provided to clone the repository for our demo app via HTTPS. |
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | Full name of the GitHub repository for our demo app. |
| <a name="output_repo_ssh_clone_url"></a> [repo\_ssh\_clone\_url](#output\_repo\_ssh\_clone\_url) | URL that can be provided to clone the repository for our demo app via SSH. |
| <a name="output_tfe_agent_token"></a> [tfe\_agent\_token](#output\_tfe\_agent\_token) | n/a |
| <a name="output_tfe_team_token"></a> [tfe\_team\_token](#output\_tfe\_team\_token) | Terraform Team Token. Use this when configuring the Run Task in Prisma Cloud. |
| <a name="output_workspace-dev-url"></a> [workspace-dev-url](#output\_workspace-dev-url) | Development Workspace URL. |
| <a name="output_workspace-prod-url"></a> [workspace-prod-url](#output\_workspace-prod-url) | Production Workspace URL. |
| <a name="output_workspace-stage-url"></a> [workspace-stage-url](#output\_workspace-stage-url) | Staging Workspace URL. |
<!-- END_TF_DOCS -->

---

## Reference:

* [Terraform: Integration guide for Prisma Cloud by Palo Alto Networks](https://developer.hashicorp.com/validated-designs/integration-patterns-guides-terraform-palo-alto-prisma-cloud-integration)
* [HCP Terraform – Prisma Cloud Run Task Integration](https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs)
* [tfe Provider Docimentation](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs)
* [GitHub Provider Documentation](https://registry.terraform.io/providers/integrations/github/latest/docs)
* [Securing Golden Images at Build Using Prisma Cloud](https://www.paloaltonetworks.com/blog/prisma-cloud/securing-golden-images-hashicorp-packer/)
---
