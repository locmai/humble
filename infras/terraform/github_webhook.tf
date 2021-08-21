// data "github_repository" "locmai_humble" {
//   full_name = "locmai/humble"
// }

// resource "github_repository_webhook" "argocd" {
//   repository = data.github_repository.locmai_humble.name
//   configuration {
//     url          = "https://${cloudflare_record.dev_ingress_records["argo"].hostname}/api/webhook"
//     content_type = "application/json"
//     insecure_ssl = false
//   }

//   active = true

//   events = ["push"]
// }