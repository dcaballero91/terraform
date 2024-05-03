provider "bigip" {
  host = "F5_management_IP"
  username = "admin"
  password = "password"
}

resource "bigip_ltm_pool" "my_pool" {
  name          = "my-pool"
  monitor       = "/Common/tcp"
  allow_snat    = "yes"
}

resource "bigip_ltm_pool_member" "my_pool_member" {
  pool_name       = bigip_ltm_pool.my_pool.name
  address         = "192.168.1.100"  # Dirección IP del miembro del pool
  port            = 80               # Puerto del miembro del pool
  connection_limit = 0               # Límite de conexiones
}
