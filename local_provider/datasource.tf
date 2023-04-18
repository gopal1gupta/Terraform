resource "local_file" "pet" {
	filename = "/root/pet.txt"
	content = data.local_file.dog.content
}

data "local_file" "dog" {
	filename = "/root/dog.txt"  ## this file is present in my local system and terraform want to reads it
	## data source are read only infrastructure
}