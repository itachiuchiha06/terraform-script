# Creating 1st EC2 instance in public subnet
resource "aws_instance" "project" {
  ami                         = "ami-0aa7d40eeae50c9a9"
  instance_type               = "t2.micro"
  key_name                    = "RAM"
  vpc_security_group_ids      = [aws_security_group.sai_sg.id]
  subnet_id                   = aws_subnet.ram_pub_sun.id
  associate_public_ip_address = true
  user_data                   = file("data.sh")
  tags = {
    Name = "project"
  }
}

# Creating 2st EC2 instance in private subnet
resource "aws_instance" "project2" {
  ami                         = "ami-0aa7d40eeae50c9a9"
  instance_type               = "t2.micro"
  key_name                    = "RAM"
  vpc_security_group_ids      = [aws_security_group.sai_sg.id]
  subnet_id                   = aws_subnet.ram_pvt_sun.id
  associate_public_ip_address = false
  user_data                   = file("data.sh")
  tags = {
    Name = "project2"
  }
}
