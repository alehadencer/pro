#указыввааем провайдера 
provider "aws" {
  version = "~> 3.0"
  region  = var.aws_region
}

resource "random_pet" "name_suffix" {}

resource "aws_s3_bucket" "my_react_app" {
  bucket = "${var.s3_bucket_name}-${random_pet.name_suffix.id}"
  acl    = "public-read"

  website {
    index_document = var.index_document
    error_document = var.error_document
  }

  force_destroy = true
}

resource "aws_s3_bucket_policy" "my_react_app_policy" {
  bucket = aws_s3_bucket.my_react_app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.my_react_app.arn}/*"
        Principal = "*"
      },
    ]
  })
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.my_react_app.website_endpoint
    origin_id   = "S3-${aws_s3_bucket.my_react_app.id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.index_document

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.my_react_app.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = var.cloudfront_price_class

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "s3_bucket_website_endpoint" {
  value       = aws_s3_bucket.my_react_app.website_endpoint
  description = "The website endpoint URL for the S3 bucket hosting the React app."
}

output "cloudfront_distribution_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution serving the React app."
}
