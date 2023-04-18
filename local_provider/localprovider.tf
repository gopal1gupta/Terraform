resource "local_file" "pet" {
	filename = "/root/pet.txt"
	content = " it contains pet name"
}

reosurce "random_pet" "mypet" {
	prefix = "Mr"
	separator ="."
	length = "1"
}
## here we have input the variables from variables.tf file
resource "local_file" "pet1" {
	filename = var.filename
	content = var.content
}
## here we are taking input varibales from the list and map
resource "local_file" "pet2" {
	filename = var.list[0]
    content = var.map["statement2"]

}

output "pet-name" {
	value = random_pet.mypet.id
}

# while running the terraform aplly u can view the ouputor
# or you can view using terraform output command