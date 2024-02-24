# Вывод URL корзины S3
output "s3_bucket_website_endpoint" {
  value       = aws_s3_bucket.my_react_app.website_endpoint
  description = "The website endpoint URL for the S3 bucket hosting the React app."
}

# Вывод доменного имени дистрибуции CloudFront
output "cloudfront_distribution_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution serving the React app."
}

# Вывод ID дистрибуции CloudFront
output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "The ID of the CloudFront distribution serving the React app."
}
