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
| [tfe_oauth_client.oauth_client](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/oauth_client) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_personal_access_token"></a> [github\_personal\_access\_token](#input\_github\_personal\_access\_token) | GitHub personal access token authorized for (HCP) Terraform (Enterprise) VCS provider use. | `string` | n/a | yes |
| <a name="input_oauth_client_api_url"></a> [oauth\_client\_api\_url](#input\_oauth\_client\_api\_url) | The base URL of your VCS provider's API. | `string` | `"https://api.github.com"` | no |
| <a name="input_oauth_client_http_url"></a> [oauth\_client\_http\_url](#input\_oauth\_client\_http\_url) | The homepage of your VCS provider. | `string` | `"https://github.com"` | no |
| <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name) | Display name for the OAuth Client. | `string` | `null` | no |
| <a name="input_oauth_client_service_provider"></a> [oauth\_client\_service\_provider](#input\_oauth\_client\_service\_provider) | The VCS provider being connected with. Valid options are ado\_server, ado\_services, bitbucket\_data\_center, bitbucket\_hosted, bitbucket\_server(deprecated), github, github\_enterprise, gitlab\_hosted, gitlab\_community\_edition, or gitlab\_enterprise\_edition. | `string` | `"github"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Name of (HCP) Terraform (Enterprise) organization. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oauth_token_id"></a> [oauth\_token\_id](#output\_oauth\_token\_id) | n/a |
<!-- END_TF_DOCS -->