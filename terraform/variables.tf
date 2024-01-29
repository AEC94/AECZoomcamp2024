variable "project"{
    description = "Default project"
    default = "zoomcamp2024-412721"
}

variable "credentials" {
    description = "Credentials for project"
    default = "keys/my-creds.json"
}

variable "bq_dataset" {
    description = "My BigQuery dataset name"
    default = "demo_dataset"
}

variable "gcs_storage_class" {
  description = "Bucket storage class"
  default = "STANDARD"
}

variable "gcs_bucket_name" {
  description = "My Storage bucket name"
  default = "zoomcamp2024-412721-terraform-bucket"
}

variable "location" {
  description = "Location for the project"
  default = "US"
}

variable "region" {
  description = "Region for the project"
  default = "southamerica-east1"
}