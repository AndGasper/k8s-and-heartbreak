resource "aws_ecr_repository" "ecr_repository" {
    name = "${var.ecr_repository_name}"
    image_tag_mutability = "IMMUTABLE"
    tags = {
        Name = "${var.ecr_repository_name}"
        Project = "k8s-and-heartbreak"
    }
}
