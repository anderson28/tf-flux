module "tls_private_key" {
  source    = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

module "github_repository" {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux-ssh-pub"
}

module "gke_cluster" {
   source           = "github.com/den-vasyliev/tf-google-gke-cluster"
   GOOGLE_REGION    = var.GOOGLE_REGION
   GOOGLE_PROJECT   = var.GOOGLE_PROJECT
   GKE_NUM_NODES    = var.GKE_NUM_NODES
   GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
}

module "flux_bootstrap" {
  source            = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = module.gke_cluster.kubeconfig
  github_token      = var.GITHUB_TOKEN
}

provider "github" {
  token = var.GITHUB_TOKEN
}

resource "github_repository_file" "commit_yaml" {
  repository = var.FLUX_GITHUB_REPO
  file       = "${var.FLUX_GITHUB_TARGET_PATH}/kbot.yaml"
  content    = file("${path.module}/kbot.yaml")

  depends_on = [module.flux_bootstrap]
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_secret" "kbot_secret" {
  metadata {
    namespace = "demo"
    name = "kbot"
  }
  data = {
    "token" = var.KBOT_TOKEN
  }
  depends_on = [module.flux_bootstrap]
}