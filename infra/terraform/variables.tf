ariable "aws_region" {
  description = "AWS region to host the S3 bucket and CloudFront distribution"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to be created for hosting the React app"
  type        = string
  # Нет значения по умолчанию, потому что имя корзины должно быть уникальным
}

variable "cloudfront_price_class" {
  description = "The price class for the CloudFront distribution (PriceClass_100, PriceClass_200, PriceClass_All)"
  type        = string
  default     = "PriceClass_100"
}

variable "index_document" {
  description = "The index document for the S3 website configuration"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "The error document for the S3 website configuration"
  type        = string
  default     = "error.html"
}
