resource "local_file" "hosts_cfg" {
  content = templatefile("current_adresses.tpl",
    {
		nat = "${yandex_compute_instance.node-1-nat.network_interface.0.nat_ip_address}"
		monitor = "${yandex_compute_instance.monitor.network_interface.0.ip_address}"
		node1 = "${yandex_compute_instance.nodes[0].network_interface.0.ip_address}"
		node2 = "${yandex_compute_instance.nodes[1].network_interface.0.ip_address}"
    }
  )
  filename = "../current_adresses.out"
}