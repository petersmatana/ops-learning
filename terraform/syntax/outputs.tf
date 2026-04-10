# var
output "application_name" {
  value = var.application_name
}

output "load_from_file" {
  value = "${var.load_from_file}, count ${length(var.load_from_file)}"
}

output "list_of_strings" {
  value = var.list_of_strings
}

output "list_of_bools" {
  value = var.list_of_bools
}

output "list_of_numbers" {
  value = var.list_of_numbers
}

output "map_of_string" {
  value = "env=${var.map_of_string["env"]};project=${var.map_of_string["project"]};artefact=${var.map_of_string["artefact"]}"
}

output "set_of_strings" {
  value = var.set_of_strings
}

# server_config object outputs
output "server_config" {
  value = var.server_config
}

output "server_config_name" {
  value = var.server_config.name
}

output "server_config_address" {
  value = "${var.server_config.address.street}, ${var.server_config.address.city}, ${var.server_config.address.country} ${var.server_config.address.zip}"
}

output "server_config_tags" {
  value = var.server_config.tags["env"]
}

output "server_config_first_port" {
  value = var.server_config.ports[0]
}

output "server_config_protocols" {
  value = var.server_config.protocols
}

# iterate list
output "set_of_strings_2" {
  value = [for x in var.set_of_strings : x]
}

# how reference resource
output "random_string_value" {
  value = random_string.string.result
}

output "random_string_value2" {
  value = random_string.string_2.result
}

# local var
output "local_description" {
  value = local.description
}

output "string" {
  value = local.play_with_string
}
