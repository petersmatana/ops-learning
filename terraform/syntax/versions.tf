# comment 1

// comment 2

/*
comment 3
*/

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8.1"
    }
  }
}
