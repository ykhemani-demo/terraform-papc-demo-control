terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.58.1"
    }
  }

  required_version = "~> 1.9.0"
}

data "tfe_organization" "org" {
  name = var.organization
}

resource "tfe_project" "project" {
  organization = data.tfe_organization.org.name
  name         = var.project
}
