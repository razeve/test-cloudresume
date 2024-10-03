# cloudfront.tf




# Define the Origin Access Identity (OAI)..
resource "aws_cloudfront_origin_access_identity" "my_oai" {
  comment = "OAI for my S3 bucket"
}

# Define the CloudFront distribution define
resource "aws_cloudfront_distribution" "my_distribution" {
  origin {
    domain_name = aws_s3_bucket.myresumebucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.myresumebucket.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.my_oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = "first.html"  

  #personal note--needed to add the A record in route53 

  aliases = ["test.razcloudresume.click"]

  default_cache_behavior {
    target_origin_id       = "S3-${aws_s3_bucket.myresumebucket.id}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"  
  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:869935106172:certificate/dba625c0-f8ec-4082-abfc-cf0429855dd5"  
    ssl_support_method             = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
    
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

  
