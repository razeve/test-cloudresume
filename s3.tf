
# Define the S3 bucket
resource "aws_s3_bucket" "myresumebucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "test"
  }
}

# Define the S3 bucket website configuration
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.myresumebucket.id

  index_document {
    suffix = "first.html"
  }

  error_document {
    key = "error.html"
  }
}

# Define the public access block configuration
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.myresumebucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}



# Define the bucket policy for public read access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.myresumebucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.myresumebucket.arn}/*",
      },
    ],
  })
}

#Uploading objects to s3
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.myresumebucket.id
  key          = "first.html"
  source       = "${path.module}/Frontend/first.html"
  etag         = filemd5("${path.module}/Frontend/first.html")
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.myresumebucket.id
  key          = "style.css"
  source       = "${path.module}/./Frontend/style.css"
  etag         = filemd5("${path.module}/Frontend/style.css")
  content_type = "text/css"
}

resource "aws_s3_object" "scripts_js" {
  bucket       = aws_s3_bucket.myresumebucket.id
  key          = "script.js"
  source       = "${path.module}/Frontend/script.js"
  etag         = filemd5("${path.module}/Frontend/script.js")
  content_type = "application/javascript"
  #depends_on   = [aws_lambda_function] making chnagesssss
}
