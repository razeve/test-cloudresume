resource "aws_dynamodb_table" "count_table" {
  name           = var.aws_dynamodb_table
  billing_mode    = "PAY_PER_REQUEST"  
  hash_key        = var.hash_key

  attribute {
    name = "id"
    type = "S"
  }
 
}

#commented here
resource "aws_dynamodb_table_item" "count_item" {
  table_name = aws_dynamodb_table.count_table.name

  hash_key = var.hash_key
  item = <<ITEM
{
  "id": {"S": "visit-record"},
  "visit": {"N": "0"}
}
ITEM

  lifecycle {
    ignore_changes = [
      item
    ]
}

}
