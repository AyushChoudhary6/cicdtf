#ec2

resource "aws_instance" "server" {
  ami           = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
  instance_type = "t2.micro"
  subnet_id     = var.sn
  security_groups = [var.sg]

  tags = {
    Name = "myserver"
  }
  
}