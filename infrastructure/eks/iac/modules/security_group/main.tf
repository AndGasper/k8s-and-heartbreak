resource "aws_security_group" "security_group_ingress" {
    name_prefix = "${var.security_group_prefix}"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = "${var.ingress_from_port}"
        to_port = "${var.ingress_to_port}"
        protocol = "${var.ingress_protocol}"

        cidr_blocks = "${var.ingress_cidr_blocks}"
    }
}