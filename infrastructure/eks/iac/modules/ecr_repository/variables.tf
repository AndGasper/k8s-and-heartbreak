variable "ecr_repository_name" {
    type = string
    description = "The name of the elastic container registry repository."
    default = "k8s-and-heartbreak"
}


variable "project_name" {
    type = string
    description = "The name of the project."
    default = "k8s-and-heartbreak"
}
