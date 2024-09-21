<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.58.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_workspace.workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | Whether destroy plans can be queued on the workspace. | `bool` | `true` | no |
| <a name="input_assessments_enabled"></a> [assessments\_enabled](#input\_assessments\_enabled) | Whether to regularly run health assessments such as drift detection on the workspace. | `bool` | `true` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful. | `bool` | `true` | no |
| <a name="input_auto_destroy_activity_duration"></a> [auto\_destroy\_activity\_duration](#input\_auto\_destroy\_activity\_duration) | A duration string of the period of time after workspace activity to automatically schedule an auto-destroy run. Must be of the form <number><unit> where allowed unit values are d and h. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the workspace. | `string` | `null` | no |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | OAuth token id for VCS provider. | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of (HCP) Terraform (Enterprise) organization. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (HCP) Terraform (Enterprise) project id. | `string` | n/a | yes |
| <a name="input_vcs_repo_branch"></a> [vcs\_repo\_branch](#input\_vcs\_repo\_branch) | The repository branch that Terraform will execute from. This defaults to the repository's default branch (e.g. main). | `string` | `null` | no |
| <a name="input_vcs_repo_identifier"></a> [vcs\_repo\_identifier](#input\_vcs\_repo\_identifier) | A reference to your VCS repository in the format <vcs organization>/<repository> where <vcs organization> and <repository> refer to the organization and repository in your VCS provider. The format for Azure DevOps is <ado organization>/<ado project>/\_git/<ado repository>. | `string` | n/a | yes |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | Name of (HCP) Terraform (Enterprise) workspace. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | n/a |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | n/a |
<!-- END_TF_DOCS -->