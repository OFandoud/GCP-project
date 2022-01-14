resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "europe-west1"

  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.subnet2.id

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "REGULAR"
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.2.0/28"
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.3.0.0/16"
    services_ipv4_cidr_block = "10.2.0.0/16"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.1.0/24"
      display_name = "management-subnet"
    }
  

  }


}

// container node pool 
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "europe-west1"
  cluster    = google_container_cluster.primary.name
  node_count = 1


  node_config {
    preemptible  = true
    machine_type = "e2-micro"
    disk_size_gb = "30"
    disk_type    = "pd-standard"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.test-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
     
    ]
  }
}