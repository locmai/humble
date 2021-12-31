resource "random_password" "tunnel_secret" {
  length  = 64
  special = false
}

resource "cloudflare_argo_tunnel" "humble_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "humble-tunnel"
  secret     = base64encode(random_password.tunnel_secret.result)
}

# Not proxied, not accessible. Just a record for auto-created CNAMEs by external-dns.
resource "cloudflare_record" "tunnel" {
  zone_id = data.cloudflare_zone.maibaloc_com.id
  type    = "CNAME"
  name    = "humble-tunnel"
  value   = "${cloudflare_argo_tunnel.humble_tunnel.id}.cfargotunnel.com"
  proxied = false
  ttl     = 1 # Auto
}


resource "kubernetes_namespace" "namespaces" {
  for_each = toset([
    "cert-manager",
    "cloudflared",
    "external-dns",
    "tekton-pipelines"
  ])

  metadata {
    name = each.key
  }
}

resource "kubernetes_secret" "cloudflared_credentials" {
  depends_on = [
    kubernetes_namespace.namespaces
  ]

  metadata {
    name = "cloudflared-credentials"
    namespace = "cloudflared"
  }

  data = {
    "credentials.json" = jsonencode({
      AccountTag   = var.cloudflare_account_id
      TunnelName   = cloudflare_argo_tunnel.humble_tunnel.name
      TunnelID     = cloudflare_argo_tunnel.humble_tunnel.id
      TunnelSecret = base64encode(random_password.tunnel_secret.result)
    })
  }
}

resource "cloudflare_api_token" "external_dns" {
  name = "homelab_external_dns"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.permissions["Zone Read"],
      data.cloudflare_api_token_permission_groups.all.permissions["DNS Write"]
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }

  condition {
    request_ip {
      in = local.public_ips
    }
  }

  lifecycle {
    ignore_changes = [
      modified_on
    ]
  }
}

resource "kubernetes_secret" "external_dns_token" {
  depends_on = [
    kubernetes_namespace.namespaces
  ]

  metadata {
    name = "cloudflare-api-token"
    namespace = "external-dns"
  }

  data = {
    "cloudflare_api_token" = cloudflare_api_token.external_dns.value
  }
}

resource "cloudflare_api_token" "cert_manager" {
  name = "homelab_cert_manager"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.permissions["Zone Read"],
      data.cloudflare_api_token_permission_groups.all.permissions["DNS Write"]
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }

  condition {
    request_ip {
      in = local.public_ips
    }
  }

  lifecycle {
    ignore_changes = [
      modified_on
    ]
  }
}

resource "kubernetes_secret" "cert_manager_token" {
  depends_on = [
    kubernetes_namespace.namespaces
  ]

  metadata {
    name = "cloudflare-api-token"
    namespace = "cert-manager"
  }

  data = {
    "api-token" = cloudflare_api_token.cert_manager.value
  }
}
