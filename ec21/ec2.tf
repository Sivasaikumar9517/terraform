resource "aws_security_group" "allow" {
    name = "Allow"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Allow-SG"
    }

}

resource "aws_instance" "terraform" {
    ami = "ami-0220d79f3f480ecf5"
    vpc_security_group_ids = [aws_security_group.allow.id]
    instance_type = "t3.micro"

    tags = {
        Name = "terraform"
        Terrafrom = "true"
    }
}