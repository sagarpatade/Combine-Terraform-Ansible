variable "aws_region" {
  default = "us-east-1"
  type = string
}

variable "aws_ami" {
  default = "ami-02dfbd4ff395f2a1b"
  type = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_group_name" {
  description = "Security group for Nginx web server"
  default = "nginx"
  type = string
}

variable "ingress" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = [ {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  },
  {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
   ]
}

variable "egress" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = [ {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    
  } ]
}

variable "task_name" {
  default = "Combine Terraform + Ansible"
  type = string
}

variable "key_pair_name" {
  type    = string
  default = "nginx-server-key"
}

variable "public_key" {
  type    = string
  default = "nginx-server-key.pub"
}