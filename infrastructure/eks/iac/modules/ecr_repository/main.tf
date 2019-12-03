resource "aws_ecr_repository" "ecr_repository" {
    name = "${var.ecr_repository_name}"
    image_tag_mutability = "IMMUTABLE"
    # Related to 
    image_scanning_configuration {
        scan_on_push = true
    }
    tags = {
        Name = "${var.ecr_repository_name}"
        Project = "${var.ecr_repository_name}"
    }
}


# ### AWS ECR Repository Policy ###
# Permissions related but I think I'd rather rely on the implicit deny behavior for now.

# ### ECR LIFECYCLE POLICIES ### 

# Note: The AWS ECR API seems to reorder rules based on rulePriority. 
# If you define multiple rules that are not sorted in ascending rulePriority order 
# in the Terraform code, the resource will be flagged 
# for recreation every terraform plan.

# A rule with a tagStatus value of any must have the highest value for rulePriority and be evaluated last.

# Groom untagged, development, staging, and production images - Arbitrary


# this could use some tlc tbh
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
    repository = "${aws_ecr_repository.ecr_repository.name}"
    policy = file("${path.module}/rules/remove_development_tagged_images_over_90_days_old.json")
} 
# Some more example rules pulled from: 
# https://aws.amazon.com/blogs/compute/clean-up-your-container-images-with-amazon-ecr-lifecycle-policies/
# Remove development tagged images over 90 days old
# Remove staging tagged images over 180 days old
# Remove production tagged images over 1 year old