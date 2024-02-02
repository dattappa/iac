# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  default = "aks"
  description = "A prefix used for all resources in this example"
}

variable "location" {
  default = "eastus"
  description = "The Azure Region in which all resources in this example should be provisioned"
}