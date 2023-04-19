resource "local_file" "pet" {
  filename = each.value
  for_each = var.filename1

  ## for_each = toset(var.filename1) --use this if varibale is list type
}
