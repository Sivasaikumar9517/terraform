resource "aws_instance" "variables" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    tags = var.ec2_tags
}

resource "aws_security_group" "allow_tls" {
    name = "Allow-all"
    description = "Allowing all the traffic"
    ingress {
        from_port = var.from_port
        to_port = var.to_port
        protocol = "tcp"
        cidr_blocks =var.cidr_blocks
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =var.cidr_blocks
    }

    tags = var.sg_tags
}