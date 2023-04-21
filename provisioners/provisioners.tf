//Provisioning mainly deals with configuration activities that happen after the resource is created.
//It may involve some file operations, executing CLI commands, or even executing the script.
//Once the resource is successfully initialized, it is ready to accept connections.
//These connections help Terraform log into the newly created instance and perform these operations.
//https://spacelift.io/blog/terraform-provisioners

resource "aws_instance" "webserver" {
  ami = "ami-0dcc1e21636832c5d"
  instance_type = "t2.micro"
  tags = {
    Name = "webserver"
    Description = " an nginx web server"


  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip}>> ip.txt"
  }

  provisioner "local-exec" {
   when = destroy
   command = "echo 'Destruction is successful.' >> destruction.txt"
 }


//  The File Provisioner
//The file provisioner is a way to copy certain files or artifacts from the host machine to target resources
//  that will be created in the future. This is a very handy way to transport certain script files, configuration files,
//artifacts like .jar files, binaries, etc. when the target resource is created and boots for the first time.
  provisioner "file" {
   source      = "./letsdotech.txt"
   destination = "/home/ec2-user/letsdotech.txt"
 }
 connection {
   type        = "ssh"
   host        = self.public_ip
   user        = "ec2-user"
   private_key = file("./tfsn.cer")
   timeout     = "4m"
 }
//  The remote-exec provisioners are similar to local-exec provisioners – where the commands are executed on the
//target EC2 instance instead of Terraform host. This is accomplished by using the same connection block that is used
//by the file provisioner.
//
//We use a remote-exec provisioner to run a single command or multiple commands. The example below performs a simple
//task on the EC2 instance that is created by Terraform. Once the EC2 instance creation is successful,
//Terraform’s remote-exec provisioner logs in to the instance via SSH and executes the commands specified in the inline attribute array.

  provisioner "remote-exec" {
   inline = [
     "touch hello.txt",
     "echo 'Have a great day!' >> hello.txt"
   ]
 }

 connection {
   type        = "ssh"
   host        = self.public_ip
   user        = "ec2-user"
   private_key = file("./tfsn.cer")
   timeout     = "4m"
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