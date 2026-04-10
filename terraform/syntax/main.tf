# RESOURCES
resource "random_string" "string" {
  length  = 10
  lower   = false
  special = false
}

resource "random_string" "string_2" {
  length = 22
  lower  = false
}

resource "random_integer" "integer" {
  min = 0
  max = 10
}

resource "random_bytes" "bytes" {
  length = 10
}

# LOCAL VARIABLES
locals {
  description        = "this is some desc. of local var"
  environment_prefix = "asd"
  local_var          = 13
  play_with_string   = "app=${var.application_name};env=${var.environemnt}"
}
