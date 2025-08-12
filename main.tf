#
# a consolidated terraform file - no version, variables, output files, all here for simplicity
#  

terraform {
    required_version = ">= 1.0.0"
    required_providers {
        ibm = {
            source  = "IBM-Cloud/ibm"
            version = ">=1.45.1"
        }
    }
}

variable "prefix" {
    type        = string
    description = "The string to represent a sample prefix."
}

variable "test" {
    type        = string
    description = "The string to represent a sample test."
}


variable "ibmcloud_api_key" {
    type        = string
    sensitive   = true
    description = "An account api key"
}

output "prefix" {
    value = var.prefix
    description = "The value of the prefix given as input."
}

provider "ibm" {
    ibmcloud_api_key = var.ibmcloud_api_key
    region           = "us-south"
}

data "ibm_is_ssh_keys" "mykeys" {
}

locals {
    howmany = length(data.ibm_is_ssh_keys.mykeys.keys)
}
output "mykeys" {
    value = "There are ${local.howmany} ssh keys defined by the account owning this api key."
}    