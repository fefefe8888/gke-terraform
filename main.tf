#resource "google_project" "twistlock-gke-3" {
#  name       = "Twistlock GKE 3"
#  project_id = "twistlock-gke-3"
#}

#resource "google_service_account" "gke-sa" {
#  account_id   = "gke-service-account"
#  display_name = "GKE Service Account"
#}

#resource "google_service_account_key" "gke-sa-key" {
#  service_account_id = google_service_account.gke-sa.name
#}

#resource "google_service_account_iam_binding" "gke-sa-iam" {
#  service_account_id = google_service_account.gke-sa.name
#  role = "role/compute.instances.get"
#
#  members = [
#    "serviceAccount:${google_service_account.gke-sa.email}"
#  ]
#}

resource "google_container_cluster" "gke-cluster-1" {
  name     = "gke-cluster-1"
  location = "us-east1-b"
  initial_node_count = 3

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {

    machine_type = "e2-small"
#    machine_type = "g1-small"

    disk_size_gb = 50

    image_type = "Ubuntu"
#    image_type = "cos"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      owner = "gcp1"
      kubernetes.io/os = "linux"
    }

    tags = ["owner", "gcp1"]
  }

#  private_cluster_config {
#    enable_private_nodes = "true"
#    enable_private_endpoint = "false"
#    master_ipv4_cidr_block = "172.16.0.0/28"
#  }

#  ip_allocation_policy {
#    cluster_ipv4_cidr_block = ""
#    services_ipv4_cidr_block = ""
#  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
