terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}
variable "nombre_maquina" {
  type    = string
  description = "El nombre de la máquina"
  default = "node-01"
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
# There are currently no configuration options for the provider itself.
variable "imagen" {
  type        = string
  description = "URL de la imagen del sistema operativo"
  default     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
}
resource "virtualbox_vm" "node" {
  count     = 1
  name      = var.nombre_maquina
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 1
  memory    = "512 mib"
  

  network_adapter {
    type = "nat"
  }
}

