resource "local_file" "pet" {
	filename = var.filename[count.index]
	## if it was only var.filename then it will create only single file

	count = 3
}

## suppose we want to add more file then
resource "local_file" "pet" {
	filename = var.filename[count.index]
	## if it was only var.filename then it will create only single file

	count = length(var.filename)
}