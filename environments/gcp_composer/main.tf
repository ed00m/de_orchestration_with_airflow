resource "google_composer_environment" "default" {
  # provider = google
  name = "${var.composer_environment}"

  config {

    node_config {
      service_account = google_service_account.terraform_custom_service_account.email
      disk_size_gb = "${var.composer_node_disk_size_gb}"
    }

  }
  # Composer GCP Labels
  labels = {
    environment = "${var.deploy_environment}"
    team_owner = "${var.deploy_team}"
  }
}