terraform {
  backend "gcs" {
    bucket  = "anderson28-tfstate"
    prefix  = "terraform/state"
  }
}

# terraform {
#   required_providers {
#     k3d = {
#       source = "pvotal-tech/k3d"
#       version = "0.0.7"
#     }
#   }
# }

# provider "k3d" {}

# resource "k3d_cluster" "demo" {
#   name    = "demo"
#   servers = 1
#   agents  = 2
#   kubeconfig {
#     update_default_kubeconfig = true
#     switch_current_context    = true
#   }
# depends_on = [ module.github_repository ]
# }