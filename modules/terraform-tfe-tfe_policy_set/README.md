<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_policy_set.policy_set](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global"></a> [global](#input\_global) | Whether or not policies in this set will apply to all workspaces. Defaults to false. | `bool` | `false` | no |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | VCS OAuth Token ID | `string` | n/a | yes |
| <a name="input_policies_path"></a> [policies\_path](#input\_policies\_path) | The sub-path within the attached VCS repository to ingress when using vcs\_repo. All files and directories outside of this sub-path will be ignored. | `string` | n/a | yes |
| <a name="input_policy_set_kind"></a> [policy\_set\_kind](#input\_policy\_set\_kind) | The policy-as-code framework associated with the policy. Defaults to sentinel if not provided. Valid values are sentinel and opa. A policy set can only have policies that have the same underlying kind. | `string` | `"sentinel"` | no |
| <a name="input_policy_set_name"></a> [policy\_set\_name](#input\_policy\_set\_name) | Name of the policy set. | `string` | n/a | yes |
| <a name="input_policy_set_repo_branch"></a> [policy\_set\_repo\_branch](#input\_policy\_set\_repo\_branch) | The repository branch that Terraform will execute from. | `string` | `"main"` | no |
| <a name="input_policy_set_repo_identifier"></a> [policy\_set\_repo\_identifier](#input\_policy\_set\_repo\_identifier) | A reference to your VCS repository in the format <vcs organization>/<repository> where <vcs organization> and <repository> refer to the organization and repository in your VCS provider. | `string` | n/a | yes |
| <a name="input_tfe_organization"></a> [tfe\_organization](#input\_tfe\_organization) | Name of (HCP) Terraform (Enterprise) organization. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_set_id"></a> [policy\_set\_id](#output\_policy\_set\_id) | n/a |
<!-- END_TF_DOCS -->