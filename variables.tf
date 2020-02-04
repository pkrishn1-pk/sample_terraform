variable "region" {
  default     = "us-south"
  description = "The VPC Region that you want your VPC, networks and the F5 virtual server to be provisioned in. To list available regions, run `ibmcloud is regions`."
}

variable "generation" {
  default     = 2
  description = "The VPC Generation to target. Valid values are 2 or 1."
}

variable "resource_group" {
  default     = "Default"
  description = "The resource group to use. If unspecified, the account's default resource group is used."
}

##############################################################################
# Provider block - Default using logged user creds
##############################################################################
provider "ibm" {
#  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
  generation            = "${var.generation}"
  region                = "${var.region}"
  resource_group        = "${var.resource_group}"
  ibmcloud_timeout      = 300
}

variable "zone" {
  default     = "us-south-1"
  description = "The VPC Zone that you want your VPC networks and virtual servers to be provisioned in. To list available zones, run `ibmcloud is zones`."
}

##############################################################################
# vpc_name - VPC where resources are to be provisioned.
##############################################################################
variable "vpc_name" {
  default     = ""
  description = "The name of your VPC where F5-BIGIP VSI is to be provisioned."
}

##############################################################################
# subnet_name - Subnet where resources are to be provisioned.
##############################################################################
variable "subnet_id"{
  default = ""
  description =" The id of the subnet where F5-BIGIP VSI to be provisioned."
}
##############################################################################
# ssh_key_name - The name of the public SSH key to be used when provisining F5-BIGIP VSI.
##############################################################################
variable "ssh_key_name" {
  default     = ""
  description = "The name of the public SSH key to be used when provisining F5-BIGIP VSI."
}

variable "vnf_profile" {
  default     = "bx2-2x8"
  description = "The profile of compute CPU and memory resources to be used when provisioning F5-BIGIP VSI. To list available profiles, run `ibmcloud is instance-profiles`."
}

