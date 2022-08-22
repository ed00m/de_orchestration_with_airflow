variable "project" {
    description = "The name of the Google Cloud Project."
}

variable "region" {
    description = "The region in with the resources are located."
    default = "southamerica-east1"
}

variable "deploy_environment" {
    description = "Name Deploy Environment."
    default = "development"
}

variable "deploy_team" {
    description = "Name Deploy team."
    default = "data-engineering"
}

variable "composer_environment" {
    description = "Name composer environment."
    default = "environment-with-terraform"
}

variable "composer_node_disk_size_gb" {
    description = "Name composer environment."
    # troubleshooting
    # Error: googleapi: Error 400: Found 1 problem:
    #   1) Disk size must be between 30GB and 64TB., badRequest
    default = 30
}