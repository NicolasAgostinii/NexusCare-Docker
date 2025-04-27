data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

data "aws_security_group" "sidral_sg" {
  filter {
    name   = "group-name"         # O campo que queremos filtrar (o nome do SG)
    values = ["sidral_sg"]        # O nome real do seu SG
  }
}
resource "aws_instance" "backend_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.imagem_ec2.id
  subnet_id = var.sn_pub01
  vpc_security_group_ids = [data.aws_security_group.sidral_sg.id]
  key_name =  data.aws_key_pair.lb_ssh_key_pair_sidral.key_name

  associate_public_ip_address = true
  tags = {
    Name = "sidral-database"
  }
}

# Criacao da chave SSH que sera usada para conexao na instancia
#resource "tls_private_key" "lb_ssh_key_grupo_d" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#

data "aws_key_pair" "lb_ssh_key_pair_sidral" {
  key_name   = "sidral_key_pair"

}
