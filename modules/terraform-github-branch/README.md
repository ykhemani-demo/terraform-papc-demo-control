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
| [github_branch.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vcs_repo_branch"></a> [vcs\_repo\_branch](#input\_vcs\_repo\_branch) | Name of VCS repo branch. | `string` | n/a | yes |
| <a name="input_vcs_repo_name"></a> [vcs\_repo\_name](#input\_vcs\_repo\_name) | The name of the repository. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_branch"></a> [branch](#output\_branch) | n/a |
<!-- END_TF_DOCS -->