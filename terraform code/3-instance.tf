// create service account  

resource "google_service_account" "test-sa" {
  account_id   = "test-service-account"
  display_name = "test-service-account"
}

resource "google_project_iam_binding" "admin-account-iam" {
  
  project = "gcp-iti-course-2021"
  role               = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.test-sa.email}",
  ]
}
resource "google_project_iam_binding" "admin" {
  
  role               = "roles/admin"
  project = "gcp-iti-course-2021"

  members = [
    "serviceAccount:${google_service_account.test-sa.email}",
  ]
}



// create a firewall rule to instance
resource "google_compute_firewall" "rules" {
  name          = "my-firewall-rule"
  network       = google_compute_network.main.name
  description   = "Creates firewall rule targeting tagged instances"
  source_ranges = ["35.235.240.0/20"]


  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }



}
// create compute instance  

resource "google_compute_instance" "vm" {
  name                      = "test"
  machine_type              = "e2-micro"
  zone                      = "europe-west1-b"
  allow_stopping_for_update = true


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }


  network_interface {
    network    = google_compute_network.main.name
    subnetwork = google_compute_subnetwork.subnet1.name

    # access_config {
    #   nat_ip = "google_compute_router_nat.nat.ip"
    # network_tier = "STANDARD"
    # }

  }

  metadata_startup_script = "echo hi > /test.txt"


  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test-sa.email
    scopes = ["cloud-platform"]
  }
}