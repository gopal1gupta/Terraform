
## this variable is defined for count
variable "filename" {
  default = [
  "root/pet.txt",
  "/root/dogs/txt",
  "/root/cats.txt"]

}

## this variable is defined for_each as each.value take only set or map type

variable "filename1" {
  type = set(string)
  default = [
  "root/pet.txt",
  "/root/dogs/txt",
  "/root/cats.txt"]

}