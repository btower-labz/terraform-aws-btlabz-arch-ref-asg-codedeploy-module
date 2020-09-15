variable "name" {
  type        = string
  description = "Code Deploy objects name prefix"
  default     = ""
}

resource "random_pet" "name" {
  count     = var.name == "" ? 1 : 0
  length    = 2
  separator = "-"
}

locals {
  name = var.name == "" ? random_pet.name[0].id : var.name
}
