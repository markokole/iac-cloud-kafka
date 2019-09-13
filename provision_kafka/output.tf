output "kafka_public_ip" {
  value = local.public_ip_address
}

output "kafka_public_dns" {
  value = local.public_dns_address
}

output "kafka_private_ip" {
  value = local.private_ip_address
}
