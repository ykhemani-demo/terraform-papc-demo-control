<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.58.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.58.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_project.project](https://registry.terraform.io/providers/hashicorp/tfe/0.58.1/docs/resources/project) | resource |
| [tfe_organization.org](https://registry.terraform.io/providers/hashicorp/tfe/0.58.1/docs/data-sources/organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | Name of (HCP) Terraform (Enterprise) organization. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of (HCP) Terraform (Enterprise) project. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | n/a |
<!-- END_TF_DOCS -->