data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

data "aws_security_group" "nexus_sg" {
  filter {
    name   = "group-name"         # O campo que queremos filtrar (o nome do SG)
    values = ["nexus_sg"]        # O nome real do seu SG
  }
}
resource "aws_instance" "s-backend_ec2" {
  instance_type = "t3.micro"
  ami = data.aws_ami.imagem_ec2.id
  subnet_id = var.sn_pub01
  vpc_security_group_ids = [data.aws_security_group.nexus_sg.id]
  key_name = data.aws_key_pair.lb_ssh_key_pair_nexus.key_name
  associate_public_ip_address = true
  tags = {
    Name = "nexus-back-end"
  }
  
}
data "aws_key_pair" "lb_ssh_key_pair_nexus" {
  key_name   = "nexus_key_pair"

}
