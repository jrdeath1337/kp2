variable "yc_cloud_id" {
  description = "b1gojnvcqc43rk3ga3js"
  type        = string
}

variable "yc_folder_id" {
  description = "b1gkcc9dpl1g7jakckh1"
  type        = string
}

variable "yc_zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-b"
}

variable "sa_key_file" {
  description = "key.json"
  type        = string
  default     = "./key.json"
}

