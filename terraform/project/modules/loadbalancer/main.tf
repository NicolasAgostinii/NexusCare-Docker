data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}


data "aws_security_group" "grupo_d_sg" {
  filter {
    name   = "group-name"         # O campo que queremos filtrar (o nome do SG)
    values = ["sg_grupo_d"]        # O nome real do seu SG
  }
}

resource "aws_network_interface" "grupo_d_nginx_ei" {
  subnet_id = var.sn_pub01
  tags = {
    Name = "sidral-pub"
  }
}

resource "aws_instance" "grupo_d_nginx_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.imagem_ec2.id
  subnet_id = var.sn_pub01
  vpc_security_group_ids = [data.aws_security_group.grupo_d_sg.id]
  key_name =  data.aws_key_pair.lb_ssh_key_pair_grupo_d.key_name
  associate_public_ip_address = true
  tags = {
    Name = "sidral-nginx"
  }

}

data "aws_key_pair" "lb_ssh_key_pair_sidral" {
  key_name   = "sidral_key_pair"

}
