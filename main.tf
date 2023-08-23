provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "angika_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.angika_vpc.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.angika_vpc.id
    cidr_block = "10.0.2.0/24"
}

resource "aws_instance" "angika_ec2_instance" {
    subnet_id = aws_subnet.public.id
    instance_type = "t2.micro"
    ami = "ami-0da59f1af71ea4ad2"
    root_block_device {
      volume_size = 8
      volume_type = "gp2"
    }
    tags = {
      Name = "Angika ec2"
      purpose = "Assignment"
    }
    vpc_security_group_ids = [aws_security_group.angika_security_group.id]
}

resource "aws_security_group" "angika_security_group"{
    name = "angika_security_group"
    vpc_id = aws_vpc.angika_vpc.id

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
}



