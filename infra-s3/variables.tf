variable "aws_region" {

}
variable "bucket_name" {
  description = "kandidat-27-data"
  type = string
}

variable "temp_prefix" {
  description = "Prefix for temporary files that lifecycle rules should target"
  type = string
  default = "midlertidig/"
}

variable "transition_days" {
  description = "Number of days before temporary file sare moved to cheaper storage (Glacier)"
  type = number
  default = 30
}

variable "expiration_days" {
  description = "Number of days before temporary files are deleted"
  type = number
  default = 90
}

variable "transition_storage_class" {
  description = "GLACIER"
  type = string
  default = "GLACIER"
}
