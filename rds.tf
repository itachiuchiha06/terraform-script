# creating RDS instance
resource "aws_db_subnet_group" "default" {
  name       = "ram-rds"
  subnet_ids = [aws_subnet.ram_pub_sun.id, aws_subnet.ram_pvt_sun.id]
  tags = {
    Name = "my_DB_subnet_group"
  }
}
resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "8.0.30"
  instance_class         = "db.t2.micro"
  multi_az               = true
  name                   = "mydb"
  username               = "charan"
  password               = "charancandy7"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}
