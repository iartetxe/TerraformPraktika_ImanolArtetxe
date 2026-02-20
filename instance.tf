data "aws_ami" "ubuntu_dinamica" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ec2_wordpress" {
  ami                         = data.aws_ami.ubuntu_dinamica.id
  instance_type               = "t3.micro"
  key_name                    = var.clavessh
  vpc_security_group_ids      = [aws_security_group.sg_servidor_web.id]
  user_data                   = file("user_data.sh")
  subnet_id                   = aws_subnet.subred_publica.id
  associate_public_ip_address = true

  tags = { Name = "Instancia-Wordpress" }
}