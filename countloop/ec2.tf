resource "aws_instance" "nginx" {
  count = 3
  ami                    = "ami-09c813fb71547fc4f"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  instance_type          = "t3.micro"
  tags = {
    Name    = var.instances[count.index]
    purpose = "Terrafrom"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "Allow-all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_route53_record" "private_ip"{
    count = 3
    zone_id ="Z02876362VLDGK59JHZ2"
    name = "${var.instances[count.index]}.${var.domain_name}"
    type = "A"
    ttl = "1"
    records = [aws_instance.nginx[count.index].private_ip]
    allow_overwrite = true
}

resource "aws_route53_record" "public_ip" {
  zone_id = "Z02876362VLDGK59JHZ2"
  name = var.domain_name
  type ="A"
  ttl ="1"
  records = [aws_instance.nginx[2].public_ip]
  allow_overwrite = true
}