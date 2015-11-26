resource "aws_vpc" "spinnaker" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "spinnaker"
    }
}

resource "aws_internet_gateway" "spinnaker" {
    vpc_id = "${aws_vpc.spinnaker.id}"

    tags {
        Name = "Spinnaker Gateway"
    }
}

/*
  Public Subnet
*/

resource "aws_subnet" "spinnaker_public" {
	vpc_id = "${aws_vpc.spinnaker.id}"

	cidr_block = "${var.public_subnet_cidr}"

    tags {
        Name = "spinnaker.internal.${var.aws_region}"
        immutable_metadata = "{ \"purpose\": \"internal\"}"
    }
}

resource "aws_route_table" "spinnaker_public" {
    vpc_id = "${aws_vpc.spinnaker.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.spinnaker.id}"
    }

    tags {
        Name = "Spinnaker Route Table"
    }
}

resource "aws_route_table_association" "spinnaker_public" {
    subnet_id = "${aws_subnet.spinnaker_public.id}"
    route_table_id = "${aws_route_table.spinnaker_public.id}"
}
