module "eks_network" {
    source = "./modules/eks_network"   
}

module "eks_cluster" {
    source = "./modules/eks_cluster"
    cluster_name = "${var.cluster_name}"
    cluster_vpc_id = "${module.eks_network.control_plane_vpc_id}"
}

module "ecr_repository" {
    source = "./modules/ecr_repository"
}

module "sns_topic" {
    source = "./modules/sns"

}
# Bad name.
module "eventbridge" {
    source = "./modules/eventbridge"
    event_rule_name = "k8s-and-heartbreak-event"
    event_rule_description = "k8s and heartbreak sample event."
    event_pattern_name = "events/detail-type/console_sign_in"
    event_target_arn = "${module.sns_topic.sns_topic_arn}"
}