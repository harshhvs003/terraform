resource "aws_instance" "web" {
  ami           = "ami-0b44050b2d893d5f7"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id

  tags = {
    Name = "HelloWorld"
  }
}
