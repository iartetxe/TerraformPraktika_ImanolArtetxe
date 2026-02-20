resource "aws_vpc" "red_principal" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.red_principal.id
}

resource "aws_subnet" "subred_publica" {
  vpc_id                  = aws_vpc.red_principal.id
  cidr_block              = "10.50.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subred_privada" {
  vpc_id                  = aws_vpc.red_principal.id
  cidr_block              = "10.50.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
}

# Tabla de rutas para acceso a internet [cite: 15, 73]
resource "aws_route_table" "tabla_rutas_publica" {
  vpc_id = aws_vpc.red_principal.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "asoc_publica" {
  route_table_id = aws_route_table.tabla_rutas_publica.id
  subnet_id      = aws_subnet.subred_publica.id
}

resource "aws_security_group" "sg_servidor_web" {
  name        = "sg_servidor_web"
  description = "Permitir HTTP, HTTPS y SSH"
  vpc_id      = aws_vpc.red_principal.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
}