resource "local_file" "pet" {
	filename = "/root/pet.txt"
	content = " it contains pet name"


	# note this rule will prevent when apply or plan command are executed but if terraform destroy is used anyhow it will destroy
	lifecycle {
		create_before_destroy = true # resource will be created first and then orlder version will be destroy

		prevent_destroy = true # prevent deletion of resources

		ignore_changes = [content] # this will prevent changes applied to content
	}


}