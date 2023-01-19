# WIF POOL

output "pool_id" {
  description = "Identifier for the pool"
  value       = google_iam_workload_identity_pool.github_actions_pool.id
}

output "pool_name" {
  description = "Name for the pool"
  value       = google_iam_workload_identity_pool.github_actions_pool.name
}

# WIF POOL PROVIDER

output "pool_provider_id" {
  description = "Identifier for the provider"
  value       = google_iam_workload_identity_pool_provider.github_actions_provider.id
}

output "pool_provider_name" {
  description = "Name for the provider"
  value       = google_iam_workload_identity_pool_provider.github_actions_provider.name
}