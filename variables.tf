variable "project" {
  type        = string
  description = "The ID of the project"
}

## WORKLOAD IDENTITY FEDERATION - POOL CREATION - 

variable "pool_id" {
  type        = string
  description = "Workload Identity Pool ID"
  default = "github-workload-identity-pool"
}

variable "pool_display_name" {
  type        = string
  description = "Workload Identity Federation Pool display name"
  default     = "github-workload-identity-pool"
}

variable "pool_disabled" {
  type        = bool
  description = "Workload Identity Federation Pool disabled"
  default     = false
}

## WORKLOAD IDENTITY FEDERATION - POOL PROVIDER CREATION - 

variable "provider_id" {
  type        = string
  description = "Workload Identity Federation Pool Provider ID"
  default = "github-action-provider"
}

variable "provider_display_name" {
  type        = string
  description = "Workload Identity Pool Federation Provider display name"
  default = "github-action-provider"
}

variable "provider_disabled" {
  type        = bool
  description = "Workload Identity Pool Provider disabled"
  default     = false
}

variable "attribute_condition" {
  type        = string
  description = "Workload Identity Pool Provider attribute condition expression"
  default     = null
}

variable "attribute_mapping" {
  type        = map(any)
  description = "Workload Identity Pool Federation Provider attribute mapping"
}

variable "allowed_audiences" {
  type        = list(string)
  description = "Workload Identity Federation Pool Provider allowed audiences"
  default     = []
}

variable "issuer_uri" {
  type        = string
  description = "Workload Identity Federation Pool Provider issuer URL"
}

## WORKLOAD IDENTITY FEDERATION - SA IMPERSONATION - 

variable "service_accounts" {
  type = list(object({
    name                  = string
    attribute             = string
  }))
  description = "Service Account names and attributes"
}