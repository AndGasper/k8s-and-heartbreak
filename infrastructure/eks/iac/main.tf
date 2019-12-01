module "eks_network" {
    source = "./modules/eks_network"   
}

module "eks_cluster" {
    source = "./modules/eks_cluster"
    cluster_name = "${var.cluster_name}"
    cluster_vpc_id = "${module.eks_network.control_plane_vpc_id}"
}