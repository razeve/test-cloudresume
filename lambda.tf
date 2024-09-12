
# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_dynamodb_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for Lambda to access DynamoDB
resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda_dynamodb_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:*"
        ]
        Resource = "arn:aws:dynamodb:us-east-2:869935106172:table/count_table"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Generates an archive from content, a file, or a directory of files

data "archive_file" "zip_the_python_code" {
 type = "zip"
 source_dir = "${path.module}/Python/"
 output_path = "${path.module}/Python/count.zip"
}


# Lambda Function
resource "aws_lambda_function" "count_function" {
  function_name = "DynamoDBVisitCounter"
  role          = aws_iam_role.lambda_role.arn
  handler       = "count.lambda_handler"
  runtime       = "python3.8"
  depends_on = [ aws_iam_role_policy_attachment.lambda_policy_attachment,data.archive_file.zip_the_python_code ]


  # Replace with the path to your count.py file zipped
  filename      = "${path.module}/Python/count.zip"
 
   environment {
    variables = {
      DYNAMODB_TABLE = var.aws_dynamodb_table
    }
  }
}

