variable "ibmcloud_api_key" {
  type		= string
}

variable "region" {
  type		= string
}

variable "zone" {
  type		= string
}

variable "workspace-name" {
  type		= string
}

variable "pi_cloud_instance_id" {
  type		= string
}

variable "pi_network_name" {
  type		= string
}

variable "pi_network_type" {
  type		= string
}

variable "pi_cidr" {
  type		= string
}

variable "pi_dns" {
  type		= string
}

variable "pi_gateway" {
  type		= string
}


variable lpar1-aix_count {
  type		= string
}


variable "lpar1-aix" {
  default = {
    "AIX-Instance-1" = { memory = 8, processors = 1 }
    "AIX-Instance-2" = { memory = 16, processors = 2 }
    "AIX-Instance-3" = { memory = 32, processors = 4 }
  }
}

variable "lpar2-linux" {
  default = {
    "Linux-Instance-1" = { memory = 4, processors = 0.5 }
    "Linux-Instance-2" = { memory = 8, processors = 1 }
    "Linux-Instance-3" = { memory = 16, processors = 2 }
  }
}

variable "lpar1-aix_memory" {
  type		= string
}

variable "lpar1-aix_processors" {
  type		= string
}

variable "lpar1-aix_instance_name" {
  type		= string
}

variable "lpar1-aix_proc_type" {
  type		= string
}

variable "lpar1-aix_image_id" {
  type		= string
}

variable "lpar1-aix_sys_type" {
  type		= string
}

variable lpar1-aix_replicants { 
  type		= string
}

#variable lpar2-linux_count {
#  type		= string
#}

variable "lpar2-linux_memory" {
  type		= string
}

variable "lpar2-linux_processors" {
  type		= string
}

variable "lpar2-linux_instance_name" {
  type		= string
}

variable "lpar2-linux_proc_type" {
  type		= string
}

variable "lpar2-linux_image_id" {
  type		= string
}

variable "lpar2-linux_sys_type" {
  type		= string
}

variable lpar2-linux_replicants { 
  type		= string
}

variable "lpar1-aix_volume_size" {
  type		= string
}

variable "lpar1-aix_volume_name" {
  type		= string
}

variable "lpar1-aix_volume_type" {
  type		= string
}

variable "lpar2-linux_volume_size" {
  type		= string
}

variable "lpar2-linux_volume_name" {
  type		= string
}

variable "lpar2-linux_volume_type" {
  type		= string
}

variable "pi_key_name" {
  type		= string
}

variable "pi_ssh_key" {
  type		= string
}

  
  
