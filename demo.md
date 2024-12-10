# Demo Guide

## Set cloud credentials locally and in HCP Terraform.

## Prepare Slack app. 

I have this come to a separate Slack workspace.

## Prepare machine images using Packer and register them in HCP Packer

Use an existing image you've registered in HCP Packer, or see [https://github.com/ykhemani-demo/packer-ubuntu-jammy](https://github.com/ykhemani-demo/packer-ubuntu-jammy) and [https://github.com/ykhemani-demo/packer-ubuntu-jammy-java](https://github.com/ykhemani-demo/packer-ubuntu-jammy-java).

You'll want to revoke an image that you will attempt to use in the course of this demo.

## Configure variables.

```
prefix                       
tfe_organization             
tfe_project                  
tfe_team                     
vcs_owner                    
repo_name                    
repo_description             
repo_visibility              
github_personal_access_token 
run_task_hcp_url             
run_task_hcp_hmac_key        
slack_webhook_url            
hcp_client_id                
hcp_client_secret            
hcp_packer_image_bucket_name 
hcp_packer_image_channel     
policy_set_repo_identifier   
tfe_agent_pool_name          
```

See [terraform.tfvars.example](terraform.tfvars.example).

## Run Terraform

```
terraform init
terraform fmt
terraform validate
terraform apply
```

This will also kick off a run of the common workspace, and provision resources in the VPC module.

## Get sensitive outputs.

```
terraform output tfe_team_token
```

## Configure Prisma Cloud - HCP Terraform integration in the Prisma Cloud UI using the team token above.

## Prepare sample repo code.

Clone the app repo that was provisioned above. We will work in a new branch called `demo-step-1`. Do this in another Terminal. 

```
git clone git@github.com:ykhemani-demo/hcp-terraform-demo.git hcp-terraform-demo-dev-branch
cd hcp-terraform-demo-dev-branch
git checkout dev
git checkout -b demo-step-1
```

## Copy the sample Terraform config from the control repo.

```
cp ../hcp-terraform-demo-control/demo-repo/instance/*tf .
cp ../hcp-terraform-demo-control/demo-repo/instance/remote.tf.example ./remote.tf
```

## Open code in VS Code

```
code .
```

## Prepare remote.tf

Update `remote.tf` with your HCP Terraform Organization and the name of your development workspace.

## Prepare your Terraform run.

```
terraform init
terraform fmt
terraform validate
```

Validate will fail. Correct `amii` -> `ami` and run `terraform validate` again.

```
terraform validate
```

## Run a speculative plan.

You can show the Terminal and Terraform UI side by side.

post-plan will fail because we're using a revoked image (HCP Packer Run Task), and because we're assigning a public IP (Prisma Cloud Run Task).

## Correct and re-run a speculative plan.

1. Shift from using a revoked image to the HCP Packer image.
2. Comment out assignment of public IP.

```
terraform plan
```

Sentinel policy check will fail due to required tags not being set.

Add the following Terraform variable. The value is in HCL.

`local_tags`:

```
{
  ttl = "24"
  owner = "you@hashicorp.com"
  bu = "Solutions Engineering"
}
```

## Re-run a speculative plan.

It will pass this time.

## Commit and push changes to the `demo-step-1` branch.

```
git add main.tf output.tf variables.tf .terraform.lock.hcl
git commit -m "demo prep"
git push -u origin demo-step-1
```

## Create a pull request (PR).

You will create a PR from the `demo-step-1` branch to the `dev` branch. The `dev` branch is tied to the `dev` workspace.

Show PR resulting in a speculative plan. You can open the PR in GitHub in one browser tab, and the Terraform run in another browser tab.

Plan, post-plan, sentinel policy will pass.

## Merge the PR

This will kick off another Terraform run (plan and apply) and the resources will get provisioned.

Show the notifications in Slack.

Show the workspace Overview, the VCS connection, outputs, state file, run history in the HCP Terraform UI.

## Create drift.

Go to the AWS Console and delete or modify a tag for the AWS instance. Make sure you're in the correct AWS region if you don't see the resources.

Kick off a drift detection.
