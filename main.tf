resource "null_resource" "named_port" {
  triggers = {
    changed = "${join(
      ",",
      formatlist("%s:%s", keys(var.named_ports), values(var.named_ports)),
    )}_for_${var.instance_group}"
  }

  provisioner "local-exec" {
    command = "${path.module}/set-named-ports.sh"

    environment = {
      INSTANCE_GROUP = var.instance_group
      NAMED_PORTS    = join(
      ",",
      formatlist("%s:%s", keys(var.named_ports), values(var.named_ports)),
      )
    }
  }
  /*
  # as it is not payed resource I think it is better to keep even removed named ports
  # then destroy & re-create on every change
  provisioner "local-exec" {
    when    = "destroy"
    command = "${path.module}/set-named-ports.sh"

    environment = {
      INSTANCE_GROUP = "${var.instance_group}"
      NAMED_PORTS = ""
    }
  }
  */
}
