# better way how to setup this varaible is to create environment variable.
# in bash: export ARM_SUBSCRIPTION_ID="id"
# in powershell: $env:ARM_SUBSCRIPTION_ID="id"

variable "azure_subscription_id" {
  description = "secret MS Azure subscription ID"
  type = string
  default = ""
}
