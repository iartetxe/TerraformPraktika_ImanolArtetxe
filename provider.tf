terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Es mejor usar una versión genérica reciente
    }
  }
}

provider "aws" {
  region     = var.region_aws
  access_key = var.clave_acceso_aws
  secret_key = var.clave_secreta_aws
  token      = var.token_sesion_aws
}