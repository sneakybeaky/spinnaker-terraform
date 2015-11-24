resource "aws_instance" "spinnaker" {
	ami = "${lookup(var.spinnaker_amis, var.aws_region)}"
	instance_type = "m4.xlarge"
	iam_instance_profile = "${aws_iam_instance_profile.spinnaker.id}"
	security_groups = ["${aws_security_group.spinnaker.id}"]
	key_name = "${var.key_name}"
	subnet_id = "${aws_subnet.spinnaker_public.id}"
	associate_public_ip_address = "true"
	source_dest_check = false
    tags {
        Name = "Spinnaker"
    }
    depends_on = ["aws_iam_instance_profile.spinnaker"]
}

resource "aws_security_group" "spinnaker" {
    name = "vpc_spinnaker"
    description = "Allow incoming connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    vpc_id = "${aws_vpc.spinnaker.id}"

    tags {
        Name = "SpinnakerSG"
    }
}

