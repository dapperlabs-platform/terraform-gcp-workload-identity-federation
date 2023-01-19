## WORKLOAD IDENTITY FEDERATION - POOL CREATION - 

resource "google_iam_workload_identity_pool" "github_actions_pool" {
  provider = google-beta
  project  = var.project

  workload_identity_pool_id = var.pool_id
  display_name              = var.pool_display_name
  description               = "Workload Identity Federation Pool managed by Terraform"
  disabled                  = var.pool_disabled
}

## WORKLOAD IDENTITY FEDERATION - POOL PROVIDER CREATION - 

resource "google_iam_workload_identity_pool_provider" "github_actions_provider" {
  provider = google-beta
  project  = var.project

  workload_identity_pool_id = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id

  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.provider_display_name
  description                        = "Workload Identity Federation Pool Provider managed by Terraform"
  disabled                           = var.provider_disabled

  attribute_mapping   = var.attribute_mapping
  attribute_condition = var.attribute_condition
  oidc {
    allowed_audiences = var.allowed_audiences
    issuer_uri        = var.issuer_uri
  }
}

## WORKLOAD IDENTITY FEDERATION - SA IMPERSONATION - 

resource "google_service_account_iam_member" "deployer_workkload_identity_user" {
  for_each = { for idx, sa in var.service_accounts : idx => sa }

  service_account_id = each.value.name
  member             = "${length(var.service_accounts) > 1 ? "principalSet" : "principal"}://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions_pool.name}/${each.value.attribute}"
  role               = "roles/iam.workloadIdentityUser"
}