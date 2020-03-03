#KeyVault Resource Group and KeyVaultName
variable "keyvault_rg" {
  type = string
}
variable "keyvault_name" {
  type = string
}

variable "azure_region" {
  description = "Azure Region where to deploy resources. Caution the region must support Availability Zone"
  # To get names of Azure Region : az account list-locations
  # To check support of Availability Zone in the Azure Region see https://docs.microsoft.com/bs-latn-ba/azure/availability-zones/az-overview
  type    = string
  default = "westeurope"
}

#  Resource Group Name
variable "resource_group" {
  type    = string
  default = "RG-AKSCluster"
}

# AKS Cluster name
variable "cluster_name" {
  type    = string
  default = "AKS-Stan1"
}

#AKS DNS name
variable "dns_name" {
  type    = string
  default = "aksstan1"
}

# Linux nodes admin user name
variable "admin_username" {
  type    = string
  default = "aksadmin"
}

# Windows nodes admin user name - Mandatory if you need at least one pool nodes with Windows nodes
variable "windows_admin_username" {
  description = "Windows Nodes admin user name"
  type        = string
  default     = "winadmin"
}

# Specify a valid kubernetes version
# Check before that the version is still available to deploy in Azure with the following command :
# az aks get-versions --location=nameofAzureRegion
variable "kubernetes_version" {
  description = "Version of Kubernetes to deploy"
  type        = string
  default     = "1.14.6"
}


#Default Agent Pool

variable "defaultpool-name" {
  description = "Name of cluster default linux nodepool"
  type        = string
  default     = "pool1"
}

variable "defaultpool-nodecount" {
  description = "Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100"
  type        = number
  default     = "2"
}

variable "defaultpool-vmsize" {
  description = "Size of VM"
  # check if the choosen size is available in Azure region you selected : az vm list-usage --location NAMEOFAZUREREGION -o table
  type        = string
  default     = "Standard_B2s"
}

variable "defaultpool-ostype" {
  description = "can be linux or windows"
  type        = string
  default     = "linux"
}

variable "defaultpool-osdisksizegb" {
  description = "Size in GB of node OS disk"
  type        = number
  default     = "32"
}

variable "defaultpool-type" {
  description = "Possible values are AvailabilitySet and VirtualMachineScaleSets"
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "defaultpool-maxpods" {
  description = "number max of pods per node. can be between 30 to 250 on Advanced Network deployment"
  type        = number
  default     = "100"
}

variable "defaultpool-availabilityzones" {
  description = "availability zones of the region" # example : [1, 2, 3]"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "defaultpool-enableautoscaling" {
  description = "use this parameter if you want an AKS Cluster with Nodes autoscaling."
  # Need also min_count and max_count parameters
  type    = bool
  default = true
}

variable "defaultpool-mincount" {
  description = "number min of nodes in pool. can be between 1 to 99"
  type        = number
  default     = "1"
}

variable "defaultpool-maxcount" {
  description = "number max of nodes in pool. can be between 2 to 99"
  type        = number
  default     = "3"
}

variable "defaultpool-nodetaints" {
  description = "A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule)"
  # cf. https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  type    = list(string)
  default = ["key=value:PreferNoSchedule"]
}

variable "defaultpool-securitypolicy" {
  type        = bool
  default     = true
}

variable "windowspool-name" {
  description = "Name of cluster windows nodepool"
  type        = string
  default     = "pool2"
}

variable "windowspool-nodecount" {
  description = "Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100"
  type        = number
  default     = "1"
}

variable "windowspool-vmsize" {
  description = "Number of node in a static AKS cluster or initial number if autoscaling. between 1 to 100"
  type        = string
  default     = "Standard_B2s"
}

variable "windowspool-ostype" {
  description = "can be Linux or Windows"
  type        = string
  default     = "Windows"
}

variable "windowspool-osdisksizegb" {
  description = "Size in GB of node OS disk"
  type        = number
  default     = "128"
}

variable "windowspool-type" {
  description = "Possible values are AvailabilitySet and VirtualMachineScaleSets"
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "winpool-maxpods" {
  description = "number max of pods per node. can be between 30 to 250 on Advanced Network deployment"
  type        = number
  default     = "100"
}

variable "winpool-availabilityzones" {
  description = "availability zones of the region" # example : [1, 2, 3]"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "winpool-enableautoscaling" {
  description = "use this parameter if you want an AKS Cluster with Nodes autoscaling."
  # Need also min_count and max_count parameters
  type    = bool
  default = true
}

variable "winpool-mincount" {
  description = "number min of nodes in pool. can be between 1 to 99"
  type        = number
  default     = "1"
}

variable "winpool-maxcount" {
  description = "number max of nodes in pool. can be between 2 to 99"
  type        = number
  default     = "3"
}

variable "winpool-nodetaints" {
  description = "A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule)"
  # cf. https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  type    = list(string)
  default = ["key=value:NoSchedule"]
}


# #AKS Agent pools
# # Minimum is 1 Linux pool
# # If you need Windows Nodes, add at least a second node pool
# variable "agent_pools" {
#   description = "List of agent_pools profile for multiple node pools Kubernetes Cluster"
#   type = list(object({
#     name                = string
#     # count               = number       # number of node in a static AKS cluster. between 1 to 100
#     vm_size             = string        # check available size in the target region : az vm list-sizes --location nameofAzureRegion 
#     os_type             = string        # can be Linux or Windows
#     os_disk_size_gb     = number        # default value is 30 GB as I remember
#     type                = string        # Possible values are AvailabilitySet and VirtualMachineScaleSets. Default value is AvailabilitySet   
#     max_pods            = number        # can be between 30 to 100 on Advanced Network deployment
#     availability_zones  = list(number)  # example : [1, 2, 3]
#     enable_auto_scaling = bool          # true or false
#     min_count           = number        # min is 1 to 99
#     max_count           = number        # max is between 2 and 100
#     node_taints         = list(string)  # cf. https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
#   }))
#   default = [
#     {
#       name            = "pool1"
#       # count           = 3              # use this parameter if you want a static number of AKS nodes  min value is 1 max value is 100
#       vm_size         = "Standard_D2_v2"
#       os_type         = "Linux"
#       os_disk_size_gb = "30"
#       type            = "VirtualMachineScaleSets"
#       max_pods        = 100
#       availability_zones = [1, 2, 3]
#       enable_auto_scaling = true   # use this parameter if you want an AKS Cluster with Nodes autoscaling. Need also min_count and max_count parameters
#       min_count           = 1      # minimum number of nodes with AKS Autoscaler
#       max_count           = 4      # maximum number of nodes with AKS Autoscaler
#       node_taints         = ["key=value:PreferNoSchedule"]  # A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule)
#     }, 
#     {
#       name            = "pool2"
#       # count           = 3              # use this parameter if you want a static number of AKS nodes  min value is 1 max value is 100
#       vm_size         = "Standard_D2_v2"
#       os_type         = "Windows"
#       os_disk_size_gb = "30"
#       type            = "VirtualMachineScaleSets"
#       max_pods        = 30
#       availability_zones = [1, 2, 3]
#       enable_auto_scaling = true   # use this parameter if you want an AKS Cluster with Nodes autoscaling. Need also min_count and max_count parameters
#       min_count           = 1      # minimum number of nodes with AKS Autoscaler
#       max_count           = 4      # maximum number of nodes with AKS Autoscaler
#       node_taints         = ["key=value:NoSchedule"]  # A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule)
#     }
#   ]
# }
