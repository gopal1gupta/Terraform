# =================Implicit Dependencies==================================
//where a resource may reference another resource
//https://www.scalr.com/blog/terraform-resource-dependencies-explained#:~:text=Part%20of%20the%20power%20of,between%20two%20resources%2Fdata%20sources

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}

#=================Explicit Dependencies==================================
#Sometimes there are dependencies between resources that are not visible to Terraform. The depends_on argument is
# accepted by any resource and accepts a list of resources to create explicit dependencies for.

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "terraform-getting-started-guide"
  acl    = "private"
}

# Change the aws_instance we declared earlier to now include "depends_on"
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = [aws_s3_bucket.example]
}