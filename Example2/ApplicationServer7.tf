resource "nutanix_virtual_machine" "windows_2019_server7" {
  name                 = "Windows Server 2019 - Example 2 Server 7"
  cluster_uuid         = data.nutanix_cluster.nutanixjeddah.cluster_id
  num_vcpus_per_socket = 2
  num_sockets          = 2
  memory_size_mib      = 8000

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = var.Windows_Server_2019_Image_UUID
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
      device_type = "DISK"
    }
  }

  nic_list {
    subnet_uuid = var.Subnet_UUID
  }

  guest_customization_sysprep = {
    install_type = "PREPARED"
    unattend_xml = var.windows_server_unattend_xml
  }
}

output "Server7IPAddress" {
  value     = nutanix_virtual_machine.windows_2019_server7.nic_list_status.0.ip_endpoint_list[0]["ip"]
  sensitive = false
}