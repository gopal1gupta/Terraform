resource "aws_instance" "webserver" {
  ami = "ami-0dcc1e21636832c5d"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver"
    Description = " an nginx web server"


  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
              EOF

  key_name = webserverkey       ###aws_key_pair.forwebserver.id

  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "forwebserver" {
  key_name = "webserverkey"
  public_key = file("/root/.ssh/web.pub") ## this key is stored locally in my machine

}


resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  description = "allow ssh sccess from the internet"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "publicip" {
  value = aws_instance.webserver.public_ip
}
## resource to create elastic ip
resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.webserver.id
}

//In this case of adding user data after instance has been created, an instance will be modified,
//but nginx will not be installed.
//It is due to the fact that User data scripts only run at first boot whereas the instance modification causes a reboot.