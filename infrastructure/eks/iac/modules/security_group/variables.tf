variable "ingress_from_port" {
    type = number
    description = "Port number to allow traffic from"
    default = 22
}

variable "ingress_to_port" {
    type = number
    description = "Port number to allow traffic to"
    default = 22
}

variable "protocol" {
    type = string
    description = "The protocol to allow traffic for; examples include: tcp, udp, icmp (pretty sure that is ping on port 8?)"
    default = "tcp"
}

variable "ingress_cidr_blocks" {
    type = list(string)
    description = "Do not use the default in production!"
    default = ["0.0.0.0/0"]
}


