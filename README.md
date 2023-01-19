# Workload Identity Federation

## What does this do?

The idea of starting to use [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation) is to replace the need to use service account keys to validate the external provider on our GCP accounts.

## How to use this module?

```hcl
module "github_actions_workload_identity_federation" {
  source = "github.com/dapperlabs-platform/terraform-google-workload-identity-federation?ref=<release>"

  project_id = module.project.project_id

  pool_id     = "github-action-identity-pool"
  provider_id = "github-action-provider"

  allowed_audiences = ["github_terraform_audience"]
  attribute_mapping = {
    "google.subject"  = "assertion.sub"
    "attribute.validate"  = "assertion.ref+assertion.environment"
  }
  issuer_uri = "https://token.actions.githubusercontent.com"

  service_accounts = [
    {
      name                  = "projects/${module.project.project_id}/serviceAccounts/${module.backend_deployer_service_account.email}"
      attribute             = "attribute.validate/refs/heads/prodprod"
    },
    {
      name                  = "projects/${module.project.project_id}/serviceAccounts/${module.frontend_deployer_service_account.email}"
      attribute             = "attribute.validate/refs/heads/prodprod"
    }
  ]
}
```

## Notes

In the `"attribute_mapping"` section you can use custom attributes and gather several assertion in order to make it easier to add the "principal/principalSet" in the service account. You have some examples of the claims to use the assertions better [here](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect#understanding-the-oidc-token)

## Requires

`terraform` [Download](https://www.terraform.io/downloads.html) [Brew](https://formulae.brew.sh/formula/terraform)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.86.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.86.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 3.87.0 |


## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_service_account_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam#google_service_account_iam_member) | resource |


## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| project| The ID of the project | `string` | n/a | yes
| pool_id | Workload Identity Federation Pool ID | `string` | `"github-workload-identity-pool"` | yes
| pool_display_name | Workload Identity Federation Pool display name | `string` | `"github-workload-identity-pool"` | no
| pool_disabled | Workload Identity Pool disabled | `bool` | `false` | no
| provider_id | Workload Identity Pool Provider ID | `string` | `"github-action-provider"` | yes
| provider_display_name | Workload Identity Pool Provider display name | `string` | `"github-action-provider"` | no
| provider_disabled | Workload Identity Pool Provider disabled | `bool` | `false` | no
| attribute_mapping | Workload Identity Pool Provider attribute mapping | `map(any)` | n/a | yes
| attribute_condition | Workload Identity Pool Provider attribute condition expression | `string` | `null` | no
| allowed_audiences | Workload Identity Pool Provider allowed audiences | `list(string)` | `[]` | no
| issuer_uri | Workload Identity Pool Provider issuer URL | `string` | n/a | yes
| service_accounts | Service Account resource names and corresponding provider attributes | <pre>list(object({<br>  name           = string<br>  attribute      = string<br>}))</pre> | n/a | yes

## Outputs

| Name | Description |
| ---- | ----------- |
| pool_id | Identifier for the pool |
| pool_name | Name for the pool |
| provider_id | Identifier for the provider |
| provider_name | Name for the provider |
