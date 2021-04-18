terraform {
  backend "etcdv3" {
    endpoints = ["192.168.1.50:2479", "192.168.1.51:2479", "192.168.1.52:2479"]
    lock      = true
    prefix    = "infras-state/"
  }
}