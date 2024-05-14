variable "GITHUB_OWNER" {
  type        = string
  description = "GitHub owner repository to use"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux GitOps repository"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subdirectory"
}

variable "GOOGLE_PROJECT" {
  type = string
}

variable "GOOGLE_REGION" {
  type = string
}

variable "GKE_NUM_NODES" {
  description = "number of nodes in GKE cluster"
  type        = string
}

variable "GKE_MACHINE_TYPE" {
  description = "type of machines that will be created for GKE cluster"
  type        = string
}

# variable "KBOT_TOKEN" {
#   type = string
#   description = "kbot token"
# }