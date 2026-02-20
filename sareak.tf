resource "aws_vpc" "nire_lehen_sarea" {
  
    cidr_block = "10.16.0.0/16"
    enable_dns_support = true

}

resource "aws_subnet" "subnet1" {

    vpc_id = aws_vpc.nire_lehen_sarea.id
    cidr_block = "10.16.100.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "subnet2" {

    vpc_id = aws_vpc.nire_lehen_sarea.id
    cidr_block = "10.16.101.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
  
}

resource "aws_security_group" "denabaimendu" {

    name = "denabaimendu"
    description = "Allow All"
    vpc_id = aws_vpc.nire_lehen_sarea.id
  
    ingress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_internet_gateway" "internetgateway" {
    vpc_id = aws_vpc.nire_lehen_sarea.id
  
}
resource "aws_route_table" "routetable1" {
    vpc_id = aws_vpc.nire_lehen_sarea.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internetgateway.id
    }
  
}

resource "aws_route_table_association" "asoc1" {
    route_table_id = aws_route_table.routetable1.id
    subnet_id = aws_subnet.subnet1.id
}

resource "aws_security_group" "mysql" {

    name = "mysql"
    description = "Allow All"
    vpc_id = aws_vpc.nire_lehen_sarea.id
  
    ingress{
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}