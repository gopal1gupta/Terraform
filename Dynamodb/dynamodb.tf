resource "aws_dynamodb_table" "cars" {
  hash_key = "VIN" ## it is primary key which is must
  name = "cars"
  attribute {    ## note primary key arrtibute must be defined
    name = "VIN"
    type = "S"
  }
}

## to add item to the table
resource "aws_dynamodb_table_item" "car-items" {
  table_name = aws_dynamodb_table.cars.name
  hash_key = aws_dynamodb_table.cars.hash_key
  item = << EOF
  {
    "manufacuturer":{"S":"Toyoto"}
    "year":{"N":"2001"}
    "VIN":{"S":"dddhkahiu"} ## S for string and N for Number
  }

}