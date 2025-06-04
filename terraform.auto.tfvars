region  = "us-south"
zone = "us-south"
workspace-name = "LPAR_Demo"
linux_size_map = {
  small = { pi_memory = 2, pi_processors = 0.25 }
  medium = { pi_memory = 4, pi_processors = 0.5 }
  large = { pi_memory = 8, pi_processors = 1 }
}
aix_size_map = {
  small = { pi_memory = 8, pi_processors = 2 }
  medium = { pi_memory = 16, pi_processors = 4 }
  large = { pi_memory = 32, pi_processors = 8 }
}
server_types = {
  linux = {
    count              = 3
    pi_size            = "small"    # <-- override default from "medium" to "small"
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
pi_network_name	= "public-subnet-1"
pi_network_type = "pub-vlan"
pi_cidr		= "10.1.0.0/24"
pi_gateway  = "10.1.0.1"
pi_dns = "8.8.8.8"
lpar1-aix_volume_size	= 100
lpar1-aix_volume_name	= "test_volume"
lpar1-aix_volume_type	= "tier3"
lpar2-linux_volume_size	= 100
lpar2-linux_volume_name	= "test_volume"
lpar2-linux_volume_type	= "tier3"
pi_key_name       = "powervs-ssh"
#pi_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZUw1yvE8A15vPk48W637EjMi/xAtugZJRyxHzmNvcsPRgkJ2ox7owgf3vJNC20yzcArV83uPZnec7lfjfWggVBpI/VETgaeeGC1UB6ilu0WO6MPD5BpVhg5HknMXtaVfmQHdG3Ycw0Ilg8DGFWjTRneTV7mpu00TYQZELBrShE9iVG5RCVQ3Fka8xt9wnCVYj/Qjo4VQyfi36zJe47/XH/Oji2ANVijpPMKHPYQizrm0t/WTdzy2iSFUJhHRqOjjQx79KTWIks2ig3jSFguzztwYKmxDRbb7M7AHS1qutVr5MSeJSxtneNYLYgxwKOx5el0zXIqD/a4ow4TlZJDjStnTFg+RaHXJ4E8sJ6zWEmIlisjKgVPpud1MPkUxRO7kuxiZ37/TxaTkVLDGWylTtNAdQj+ih2h+FtPtHE3VJkOIAI3FTX1GSEdTQoH5eEs/xgLYCIg4ANcSEOoyaJqVgFnQInmXuXd0Hq391AMcOmWugPCioVHcJeanSSeQxw0M= sap"
