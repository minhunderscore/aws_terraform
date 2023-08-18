locals {
  prefix_name = "${var.global_variables["project"]}-${var.global_variables["owner"]}-${var.global_variables["environment"]}-${var.module_name}"
}