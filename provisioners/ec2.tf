resource "aws_instance" "nginx" {
  ami                    = "ami-0220d79f3f480ecf5"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = "nginx"
    purpose = "Terrafrom"
  }

  provisioner "local-exec" {
    command = "echo 'i am doing local exec' "
    on_failure = continue
  }

  # provisioner "local-exec"{
  #   command = "echo ${self.private_ip} > inventory"
  #   on_failure = continue
  # }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory.ini"
    on_failure = continue
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"

    ]
    on_failure = continue
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop nginx",
      "echo 'stopped the nginx' "
    ]
    when = destroy
  }

}

resource "aws_security_group" "allow_tls" {
  name        = "Allow-everything"
  description = "Allow TLS inbound traffic and all outbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-all"
  }
}