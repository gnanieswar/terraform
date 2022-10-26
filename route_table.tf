#Creating Route Table
resource "aws_route_table" "route" {
    vpc_id = "${var.vpc_id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demogateway.id}"
    }

    tags = {
        Name = "Route to internet"
    }
}

resource "aws_route_table_association" "rt1" {
    subnet_id = "${var.subnet_DDP-QA-Web-Zone}"
    route_table_id = "${aws_route_table.route.id}"
}

resource "aws_route_table_association" "rt2" {
    subnet_id = "${var.subnet_DDP-QA-Web-Zone-2}"
    route_table_id = "${aws_route_table.route.id}"
}