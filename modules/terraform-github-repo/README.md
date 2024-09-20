<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repo_visibility"></a> [repo\_visibility](#input\_repo\_visibility) | Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal. The visibility parameter overrides the private parameter. | `string` | `"private"` | no |
| <a name="input_vcs_repo_name"></a> [vcs\_repo\_name](#input\_vcs\_repo\_name) | The name of the repository. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_full_name"></a> [full\_name](#output\_full\_name) | n/a |
| <a name="output_html_url"></a> [html\_url](#output\_html\_url) | n/a |
| <a name="output_http_clone_url"></a> [http\_clone\_url](#output\_http\_clone\_url) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_ssh_clone_url"></a> [ssh\_clone\_url](#output\_ssh\_clone\_url) | n/a |
<!-- END_TF_DOCS -->