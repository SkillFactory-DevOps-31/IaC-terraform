data "yandex_compute_image" "image-1-ubuntu-2204-lts" {
  family = "ubuntu-2204-lts"
}

data "yandex_compute_image" "image-1-ubuntu-nat" {
  family = "nat-instance-ubuntu"
}