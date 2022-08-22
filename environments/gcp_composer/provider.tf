# # terraform -configurations
# terraform {
#   backend "gcs" {
#     bucket = "terraform_devoteam_development"
#     path = "terraform.tfstate"
#     project = "devoteam_development"
#   }
# }

# Google Provider - configurations
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}
# Google Provider - composer service enable
resource "google_project_service" "composer_api" {
  # provider = google
  project = "${var.project}"
  service = "composer.googleapis.com"
  // Disabling Cloud Composer API might irreversibly break all other
  // environments in your project.
  // This parameter prevents automatic disabling
  // of the API when the resource is destroyed.
  // We recommend to disable the API only after all environments are deleted.
  disable_on_destroy = false
}
# Google Provider - service account
resource "google_service_account" "terraform_custom_service_account" {
  # provider = google
  account_id   = "terraform-account-deploy"
  display_name = "Terraform Service Account"
}
# Google Provider - iam roles & service account
resource "google_project_iam_member" "terraform_custom_service_account" {
  # provider = google
  project  = "${var.project}"
  member   = format("serviceAccount:%s", google_service_account.terraform_custom_service_account.email)
  // Role for Public IP environments
  role     = "roles/composer.worker"
}