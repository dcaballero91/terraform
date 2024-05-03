variable "nombre_maquina" {
  type        = string
  description = "El nombre de la máquina"
  default     = "node-01"
}

variable "cpus" {
  type        = number
  description = "Cantidad de CPUs"
  default     = 1
}

variable "ram" {
  type        = string
  description = "Cantidad de memoria RAM en MB"
  default     = "512"
}

variable "datacenter" {
  type        = string
  description = "Nombre del datacenter de vSphere"
}

variable "cluster" {
  type        = string
  description = "Nombre del cluster de vSphere"
}

variable "datastore" {
  type        = string
  description = "Nombre del datastore de vSphere"
}

variable "template" {
  type        = string
  description = "Nombre de la plantilla de VM en vSphere"
}

variable "network" {
  type        = string
  description = "Nombre de la red de vSphere"
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.nombre_maquina
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  num_cpus         = var.cpus
  memory           = var.ram
  guest_id         = var.template
  network_interface {
    network_id = data.vsphere_network.network.id
  }
}
