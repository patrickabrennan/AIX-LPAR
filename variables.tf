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

#ADDED 6/3/25
variable "linux_size_map" {
  type = map(object({
    pi_memory     = number
    pi_processors = number
  }))
  description = "Linux size definitions"
}

variable "aix_size_map" {
  type = map(object({
    pi_memory     = number
    pi_processors = number
  }))
  description = "AIX size definitions"
}
#END 6/3/25

variable "server_types" {
  type = map(object({
    count              = number
    pi_size            = string           # size label like "small", "large"
    pi_instance_name   = string
    pi_proc_type       = string
    pi_image_id        = string
    pi_sys_type        = string
  }))

  default = {
    linux = {
      count              = 2
      pi_size            = "medium"
      pi_instance_name   = "linux"
      pi_proc_type       = "shared"
      pi_image_id        = "RHEL9-SP4"
      pi_sys_type        = "s922"
    }
    aix = {
      count              = 2
      pi_size            = "medium"
      pi_instance_name   = "aix"
      pi_proc_type       = "dedicated"
      pi_image_id        = "7300-03-00"
      pi_sys_type        = "s922"
    }
  }
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

#commented out 6/3/25
#variable lpar1-aix_count {
#  type		= string
#}

#variable "lpar1-aix_memory" {
#  type		= string
#}

#variable "lpar1-aix_processors" {
#  type		= string
#}

#variable "lpar1-aix_instance_name" {
#  type		= string
#}

#variable "lpar1-aix_proc_type" {
#  type		= string
#}

#variable "lpar1-aix_image_id" {
#  type		= string
#}

#variable "lpar1-aix_sys_type" {
#  type		= string
#}

#variable lpar1-aix_replicants { 
#  type		= string
#}

#variable "lpar2-linux_memory" {
#  type		= string
#}

#variable "lpar2-linux_processors" {
#  type		= string
#}

#variable "lpar2-linux_instance_name" {
#  type		= string
#}

#variable "lpar2-linux_proc_type" {
#  type		= string
#}

#variable "lpar2-linux_image_id" {
#  type		= string
#}

#variable "lpar2-linux_sys_type" {
#  type		= string
#}

#variable lpar2-linux_replicants { 
#  type		= string
#}

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
