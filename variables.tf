variable "clave_acceso_aws" {}
variable "clave_secreta_aws" {}
variable "token_sesion_aws" {}

variable "region_aws" {
  default = "us-east-1"
}

variable "clavessh" {
  description = "clavessh"
  type        = string
}

variable "usuario_bd" {
  default = "admin_wp"
}

variable "contrasena_bd" {
  default = "Admin1234Wordpress"
}