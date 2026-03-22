resource "aws_security_group" "nginx-sg" {
  name = var.security_group_name

  dynamic "ingress" {
    for_each = var.ingress

    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks

    }
  }

  dynamic "egress" {
    for_each = var.egress

    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.task_name}-nginx-sg"
  }
}    
  