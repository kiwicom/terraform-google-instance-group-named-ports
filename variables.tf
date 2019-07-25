variable "instance_group" {
  description = "self_link of instance group to update"
}

variable "named_ports" {
  description = "Map of named ports { name = port_number }"
  type        = map(number)
}
