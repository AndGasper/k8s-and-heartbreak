output "bucket_website_domain" {
    value = "${module.static-site.s3_bucket_website_domain}"
    description = "The website domain for the s3 bucket"
}

output "bucket_hosted_zone_id" {
    value = "${module.static-site.s3_bucket_hosted_zone_id}"
    description = "The hosted zone id of the s3 bucket used for the site"
}

output "website_url" {
    value = "${module.static-site.s3_bucket_domain_name}"
    description = "The s3 website domain"
}

output "bucket_regional_domain_name" {
    value = "${module.static-site.bucket_regional_domain_name}"
}