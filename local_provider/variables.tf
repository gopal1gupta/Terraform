variable "filename"{
	default = "/root/pet.txt"

}

variable "content" {
	default =" this is my fav pet"
}

variable "types" {
	type = string
	## support variable types are
	## 1. string , number, bool , any
	## 2. list , map, object, tuples

}

variable "list" {
	default= ["a","b",c] ##  ---->index start with 0
	type = list

}

variable "map" {
	type= map
	default = {
		"statement1" = " we love pets"
		"statement2" = "we love dogs"
	}

}

variable "set" {
	type = set(number)
	default = [ 1, 2 , 3 ]  # ----> if there are duplicate values it willt hrow an error
}

## what if our variables is like below
It will basically ask variable input in terminal when you run terraform apply
variable "filename"{


}

variable "content" {

}

variable "types" {


}

variable "list" {


}

variable "map" {

	}

}

variable "set" {

}

## we can also use
terraform apply -var "filename = /root/pet.xt" -var "content = this is my pet"

we can also use

export TF_VAR_filename = "/root/pet.txt"