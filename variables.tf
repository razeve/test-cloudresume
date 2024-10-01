variable "bucket_name" {
    description = "The name of the s3 bucket"
    type = string
}

variable "region" {
    description = "The location of the region"
    type = string
    default = "us-east-2"
}

variable "domain_name" {
    description = "this is the name of the doamin"
    type = string
  
}

variable "aws_dynamodb_table" {
    description = "This is table name in dynamodb"
    type = string
    default = "count_table"
  
}

variable "hash_key" {
    description = "hash key name"
    type = string
    default = "id"
  
}

variable "api_gateway_name" {
    description = "This is api gateway name"
    type = string
    default = "DynamoDBVisitCounterAPI"
  
}