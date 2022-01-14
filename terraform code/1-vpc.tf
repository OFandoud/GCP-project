resource "google_compute_network" "main" {
  name                    = "final-lab-vpc"
  auto_create_subnetworks = "false"
}