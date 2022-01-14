// subnet 1
resource "google_compute_subnetwork" "subnet1" {
  name          = "management-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.main.id
}
// subnet 2
resource "google_compute_subnetwork" "subnet2" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west1"
  network       = google_compute_network.main.id
}

//nat gateway
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet1.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


// router 
resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.main.id
  region  = "europe-west1"
  bgp {
    asn            = 64514
    advertise_mode = "CUSTOM"
  }
}

