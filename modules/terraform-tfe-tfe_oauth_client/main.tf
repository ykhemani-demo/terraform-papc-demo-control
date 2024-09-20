terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58"
    }
  }

  required_version = "~> 1.9.0"
}

resource "tfe_oauth_client" "oauth_client" {
  name             = var.oauth_client_name
  organization     = var.organization
  api_url          = var.oauth_client_api_url
  http_url         = var.oauth_client_http_url
  oauth_token      = var.github_personal_access_token
  service_provider = var.oauth_client_service_provider
}

