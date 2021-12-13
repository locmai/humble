locals {
  public_ips = [
    "${chomp(data.http.public_ipv4.body)}/32",
    "${chomp(data.http.public_ipv6.body)}/128"
  ]
}