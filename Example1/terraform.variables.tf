variable cluster_id {
  type = string
}

variable prism_username {
  type = string
}

variable prism_password {
  type = string
}

variable prism_endpoint {
  type = string
}

variable prism_insecure {
  type    = bool
  default = true
}

variable prism_port {
  type    = number
  default = 9440
}

variable prism_wait_timeout {
  type    = number
  default = 10
}

variable Windows_Server_2019_Image_UUID {
  type = string
}

variable Subnet_UUID {
  type = string
}

variable windows_server_unattend_xml {
  type = string
}