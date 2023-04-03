resource "yandex_compute_instance" "node-1-nat" {
  name        = "node-1-nat"
  platform_id = "standard-v2"

  depends_on = [yandex_vpc_subnet.subnet-c-1]

  resources {
    cores         = 2
    memory        = 1
	core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image-1-ubuntu-nat.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-c-1.id
	ipv4 = true
	ip_address = "192.168.10.254"
    nat  = true
  }

  metadata = {
    user-data = file("users.yaml")
    "serial-port-enable" : "1"
  }
}

resource "yandex_compute_instance" "monitor" {
  name        = "monitor"
  platform_id = "standard-v2"

  depends_on = [yandex_vpc_subnet.subnet-c-1]

  resources {
    cores         = 2
    memory        = 1
	core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image-1-ubuntu-2204-lts.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-c-1.id
  }

  metadata = {
    user-data = file("users.yaml")
    "serial-port-enable" : "1"
  }
}

resource "yandex_compute_instance" "nodes" {
  count = 2
  
  name        = format("node-%s-ubuntu-2204-lts", count.index)
  platform_id = "standard-v2"

  depends_on = [yandex_vpc_subnet.subnet-c-1]

  resources {
    cores         = 2
    memory        = 2
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image-1-ubuntu-2204-lts.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-c-1.id
  }

  metadata = {
    user-data = file("users.yaml")
    "serial-port-enable" : "1"
  }
}
