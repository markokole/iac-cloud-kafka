variable "configuration" {
}

variable "path_in_consul" {
  default = "test/master/azure"
}

variable "path_in_consul_kafka" {
  default = "test/master/kafka"
}

variable "consul_server" {
  default = "34.200.245.90"
}

variable "consul_port" {
  default = "8500"
}

variable "datacenter" {
  default = "dc1"
}

data "consul_keys" "app" {
  key {
    name = "path_to_generated_azure_properties"
    path = "${var.path_in_consul}/path_to_generated_azure_properties"
  }
}

data "consul_keys" "kafka" {
  key {
    name = "zookeeper_url"
    path = "${var.path_in_consul_kafka}/${var.configuration}/zookeeper_url"
  }
  key {
    name = "kafka_url"
    path = "${var.path_in_consul_kafka}/${var.configuration}/kafka_url"
  }
  key {
    name = "project"
    path = "${var.path_in_consul_kafka}/${var.configuration}/project"
  }
  key {
    name = "id_rsa_path"
    path = "${var.path_in_consul_kafka}/${var.configuration}/id_rsa_path"
  }
}

data "consul_keys" "address" {
  key {
    name    = "public_ip_address"
    path    = "${local.path_to_generated_azure_properties}/${local.project}/public_ip_address"
  }
  key {
    name    = "private_ip_address"
    path    = "${local.path_to_generated_azure_properties}/${local.project}/private_ip_address"
  }
  key {
    name    = "public_dns_address"
    path    = "${local.path_to_generated_azure_properties}/${local.project}/public_dns_address"
  }
}

