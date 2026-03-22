resource "aws_key_pair" "my-key" {
  key_name = var.key_pair_name
  public_key = file("${var.public_key}")
}

resource "aws_instance" "nginx-ec2" {
  ami = var.aws_ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  key_name = aws_key_pair.my-key.key_name

  tags = {
    Name = "${var.task_name}-nginx-server"
  }

}