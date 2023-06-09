resource "aws_instance" "mario_servers" {
     ami = var.ami
     instance_type = var.name == "tiny" ? var.small : var.large
     tags = {
          Name = var.name

     }

}
//Instance_type: Use a conditional expression so that - If the instance is created with a tag Name = "tiny",
it should use the variable called small else the variable called large
//
//We will supply the variable called name using the -var command line flag