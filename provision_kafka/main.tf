locals {
  path_to_generated_azure_properties = "${var.path_in_consul}/${data.consul_keys.app.var.path_to_generated_azure_properties}"
  workdir                            = "${path.cwd}/output"

  private_ip_address  = split(",", data.consul_keys.address.var.private_ip_address)
  public_ip_address   = split(",", data.consul_keys.address.var.public_ip_address)
  public_dns_address  = split(",", data.consul_keys.address.var.public_dns_address)
  no_nodes            = length(local.private_ip_address)
  project             = data.consul_keys.kafka.var.project
  id_rsa_path         = data.consul_keys.kafka.var.id_rsa_path
  zookeeper_url       = data.consul_keys.kafka.var.zookeeper_url
  kafka_url           = data.consul_keys.kafka.var.kafka_url

  // variable tells whether there are IP addresses available (1) or not (0)
  execute             = local.no_nodes > 0 ? 1 : 0
}

resource "null_resource" "install_kafka" {
  count = local.execute
  
  provisioner "local-exec" {
    command = <<EOF
export ANSIBLE_HOST_KEY_CHECKING=False; \
ansible-playbook --inventory=${local.workdir}/ansible-hosts \
                 ${path.module}/resources/ansible/kafka.yml \
                 --extra-vars local_workdir=${local.workdir}
EOF
  }
}

