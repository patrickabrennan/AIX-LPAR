terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.71.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key   = var.ibmcloud_api_key
  region= var.region
  zone = var.zone
}

data "ibm_resource_group" "group" {
  name = "Default"
}

data "ibm_resource_instance" "powervs" {
  name = var.workspace-name
  service = "power-iaas"
  location = var.region
  depends_on = [ ibm_pi_workspace.powervs_service_instance ]
}

output "pi_cloud_instance_id" {
  value = data.ibm_resource_instance.powervs.guid
}

resource "ibm_pi_workspace" "powervs_service_instance" {
  pi_name               = var.workspace-name
  pi_datacenter         = var.region
  pi_resource_group_id  = data.ibm_resource_group.group.id
}

#Create a subnet
resource "ibm_pi_network" "my_subnet" { 
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_network_name	= var.pi_network_name
  pi_network_type	= var.pi_network_type
  pi_network_mtu       = "9000"
  pi_cidr		= var.pi_cidr
  #pi_gateway  = var.pi_gateway
  pi_dns = ["8.8.8.8"]
}

#Added 6/3
#locals {
#  linux_size_map = {
#    small = {
#      pi_memory     = 2
#      pi_processors = 0.25
#    }
#    medium = {
#      pi_memory     = 4
#      pi_processors = 0.5
#    }
#    large = {
#      pi_memory     = 8
#      pi_processors = 1
#    }
#  }

#  aix_size_map = {
#    small = {
#      pi_memory     = 8
#      pi_processors = 2
#    }
#    medium = {
#      pi_memory     = 16
#      pi_processors = 4
#    }
#    large = {
#      pi_memory     = 32
#      pi_processors = 8
#    }
#  }
#}

#locals {
#  instances = flatten([
#    for server_type, config in var.server_types : [
#      for i in range(config.count) : {
#        key               = "${server_type}-${i}"
#        server_type       = server_type
#        index             = i
#        pi_instance_name  = config.pi_instance_name
#        pi_proc_type      = config.pi_proc_type
#        pi_image_id       = config.pi_image_id
#        pi_sys_type       = config.pi_sys_type
#
#        # Memory and processor selection per platform
#        pi_memory     = server_type == "linux" ? local.linux_size_map[config.pi_size].pi_memory : local.aix_size_map[config.pi_size].pi_memory
#        pi_processors = server_type == "linux" ? local.linux_size_map[config.pi_size].pi_processors : local.aix_size_map[config.pi_size].pi_processors
#      }
#    ]
#  ])
#
#  instance_map = { for inst in local.instances : inst.key => inst }
#}

locals {
  instances = flatten([
    for server_type, config in var.server_types : [
      for i in range(config.count) : {
        key               = "${server_type}-${i}"
        server_type       = server_type
        index             = i
        pi_instance_name  = config.pi_instance_name
        pi_proc_type      = config.pi_proc_type
        pi_image_id       = config.pi_image_id
        pi_sys_type       = config.pi_sys_type

        pi_memory     = server_type == "linux"
          ? var.linux_size_map[config.pi_size].pi_memory
          : var.aix_size_map[config.pi_size].pi_memory

        pi_processors = server_type == "linux"
          ? var.linux_size_map[config.pi_size].pi_processors
          : var.aix_size_map[config.pi_size].pi_processors
      }
    ]
  ])

  instance_map = { for inst in local.instances : inst.key => inst }
}







resource "ibm_pi_instance" "vm" {
  for_each = local.instance_map

  pi_memory        = each.value.pi_memory
  pi_processors    = each.value.pi_processors
  pi_instance_name = "${each.value.pi_instance_name}-${each.value.index}"
  pi_proc_type     = each.value.pi_proc_type
  pi_image_id      = each.value.pi_image_id
  pi_sys_type      = each.value.pi_sys_type
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_key_pair_name = var.pi_key_name
  pi_network {
    network_id = ibm_pi_network.my_subnet.network_id
  }
}

#create Volume
resource "ibm_pi_volume" "lpar1-aix_test_volume" {
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_volume_size	= var.lpar1-aix_volume_size
  pi_volume_name	= var.lpar1-aix_volume_name
  pi_volume_type	= var.lpar1-aix_volume_type 
}

#create Volume
resource "ibm_pi_volume" "lpar2-linux_test_volume" {
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_volume_size	= var.lpar2-linux_volume_size
  pi_volume_name	= var.lpar2-linux_volume_name
  pi_volume_type	= var.lpar2-linux_volume_type 
}

#resource "ibm_pi_volume_attach" "lpar1-aix_test_volume" {
#  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
#  pi_volume_id = ibm_pi_volume.lpar1-aix_test_volume.volume_id
#  pi_instance_id = ibm_pi_instance.lpar1-aix.instance_id
#}

#resource "ibm_pi_volume_attach" "lpar2-linux_test_volume" {
#  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
#  pi_volume_id = ibm_pi_volume.lpar2-linux_test_volume.volume_id
#  pi_instance_id = ibm_pi_instance.lpar2-linux.instance_id
#}

resource "ibm_security_group" "sg1" {
  name = "sg1"
  description = "allow my app traffic"
}

resource "ibm_security_group_rule" "allow_port_22" {
  direction = "ingress"
  ether_type = "IPv4"
  port_range_min = 22
  port_range_max = 22
  protocol = "tcp"
  security_group_id = ibm_security_group.sg1.id
}

resource "ibm_pi_key" "PowerVS_sshkey" {
  pi_key_name       = var.pi_key_name
  pi_ssh_key = var.pi_ssh_key
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid  #var.pi_cloud_instance_id
}
