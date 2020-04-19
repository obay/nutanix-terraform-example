provider "nutanix" {
  version      = "~> 1.0"
  username     = var.prism_username
  password     = var.prism_password
  endpoint     = var.prism_endpoint
  insecure     = var.prism_insecure
  port         = var.prism_port
  wait_timeout = var.prism_wait_timeout
}
