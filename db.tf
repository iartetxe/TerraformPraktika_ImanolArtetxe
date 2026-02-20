# Security Group para RDS (Solo permite tráfico del SG del EC2)
resource "aws_security_group" "sg_rds" {
  name        = "sg_base_datos"
  vpc_id      = aws_vpc.red_principal.id
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_servidor_web.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "grupo_subred_rds" {
  name       = "grupo-subred-bd"
  subnet_ids = [aws_subnet.subred_publica.id, aws_subnet.subred_privada.id]
}

resource "aws_db_instance" "base_datos_wp" {
  allocated_storage         = 10
  db_name                   = "wordpressdb"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t3.micro"
  skip_final_snapshot       = true
  username                  = var.usuario_bd
  password                  = var.contrasena_bd
  db_subnet_group_name      = aws_db_subnet_group.grupo_subred_rds.name
  vpc_security_group_ids    = [aws_security_group.sg_rds.id]
  availability_zone         = aws_subnet.subred_privada.availability_zone
}