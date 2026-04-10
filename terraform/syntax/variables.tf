variable "application_name" {
  description = "name of the application"
  type        = string
  default     = "my_app"
  validation {
    condition     = length(var.application_name) > 0 && length(var.application_name) <= 32
    error_message = "application_name must be between 1 and 32 characters."
  }
}

variable "environemnt" {
  description = "env"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environemnt)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "increment_number" {
  description = "some value which is incremented"
  type        = number
  default     = 13
  validation {
    condition     = var.increment_number >= 0 && var.increment_number <= 100
    error_message = "increment_number must be between 0 and 100."
  }
}

variable "bool_var" {
  description = "this is example of bool var"
  type        = bool
  default     = false
  validation {
    condition     = var.bool_var == true || var.bool_var == false
    error_message = "bool_var must be true or false."
  }
}

variable "list_of_strings" {
  description = "this is example of list of strings"
  type        = list(string)
  default     = ["a", "b", "c"]
  validation {
    condition     = length(var.list_of_strings) > 0
    error_message = "list_of_strings must not be empty."
  }
}

variable "list_of_numbers" {
  description = "this is example of list of numbers"
  type        = list(number)
  default     = [1, 2, 3]
  validation {
    condition     = alltrue([for n in var.list_of_numbers : n >= 0])
    error_message = "all numbers in list_of_numbers must be non-negative."
  }
}

variable "list_of_bools" {
  description = "this is example of list of bools"
  type        = list(bool)
  default     = [true, false, true]
  validation {
    condition     = length(var.list_of_bools) > 0
    error_message = "list_of_bools must not be empty."
  }
}

variable "map_of_string" {
  description = "this is example of map of string"
  type        = map(string)
  default     = {
    "env"      = "dev"
    "project"  = "my_app"
    "artefact" = "backend"
  }
  validation {
    condition     = contains(keys(var.map_of_string), "env")
    error_message = "map_of_string must contain the key 'env'."
  }
}

variable "map_of_number" {
  description = "this is example of map of number"
  type        = map(number)
  default     = {
    "min"     = 1
    "max"     = 100
    "default" = 13
  }
  validation {
    condition     = var.map_of_number["min"] < var.map_of_number["max"]
    error_message = "map_of_number: 'min' must be less than 'max'."
  }
}

variable "map_of_bool" {
  description = "this is example of map of bool"
  type        = map(bool)
  default     = {
    "is_enabled"  = true
    "is_public"   = false
    "is_internal" = true
  }
  validation {
    condition     = contains(keys(var.map_of_bool), "is_enabled")
    error_message = "map_of_bool must contain the key 'is_enabled'."
  }
}

variable "set_of_strings" {
  description = "this is example of set of strings"
  type        = set(string)
  default     = ["a", "b", "c"]
  validation {
    condition     = length(var.set_of_strings) > 0
    error_message = "set_of_strings must not be empty."
  }
}

variable "set_of_numbers" {
  description = "this is example of set of numbers"
  type        = set(number)
  default     = [1, 2, 3]
  validation {
    condition     = length(var.set_of_numbers) > 0
    error_message = "set_of_numbers must not be empty."
  }
}

variable "server_config" {
  description = "this is example of object with mixed types"
  type = object({
    name     = string
    strength = number
    boarding = bool
    address = object({
      street  = string
      city    = string
      country = string
      zip     = string
    })
    tags      = map(string)
    ports     = list(number)
    protocols = set(string)
  })
  default = {
    name     = "my_server"
    strength = 8
    boarding = true
    address = {
      street  = "123 Main St"
      city    = "New York"
      country = "USA"
      zip     = "10001"
    }
    tags = {
      "env"  = "dev"
      "team" = "backend"
    }
    ports     = [80, 443, 8080]
    protocols = ["tcp", "udp"]
  }
  validation {
    condition     = length(var.server_config.name) > 0
    error_message = "server_config.name must not be empty."
  }
  validation {
    condition     = var.server_config.strength >= 1 && var.server_config.strength <= 10
    error_message = "server_config.strength must be between 1 and 10."
  }
  validation {
    condition     = length(var.server_config.address.zip) == 5
    error_message = "server_config.address.zip must be exactly 5 characters."
  }
  validation {
    condition     = alltrue([for p in var.server_config.ports : p > 0 && p <= 65535])
    error_message = "server_config.ports must contain valid port numbers (1-65535)."
  }
  validation {
    condition     = alltrue([for p in var.server_config.protocols : contains(["tcp", "udp", "icmp"], p)])
    error_message = "server_config.protocols must only contain: tcp, udp, icmp."
  }
}

variable "load_from_file" {
  description = "this variable is loaded from file terraform.tfvars"
}
