resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_route_table" "natted-rt-1" {
  network_id = "${yandex_vpc_network.network-1.id}"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

resource "yandex_vpc_subnet" "subnet-c-1" {
  depends_on = [yandex_vpc_route_table.natted-rt-1]
  name           = "subnet-192-168-10"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  
  route_table_id = "${yandex_vpc_route_table.natted-rt-1.id}"
}