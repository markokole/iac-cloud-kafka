data "template_file" "generate_inventory" {
  count    = local.no_nodes
  template = file("${path.module}/resources/templates/inventory.tmpl")
  vars = {
    node_text = "${element(local.private_ip_address, count.index)} ansible_host=${element(local.public_ip_address, count.index)} public_dns=${element(local.public_dns_address, count.index)} zookeeper_id=${count.index + 1} ansible_user=centos ansible_ssh_private_key_file=\"${local.id_rsa_path}\""
  }
}

# create the yaml file based on template and the input values
resource "local_file" "ansible_inventory_render" {
  count    = local.execute
  content  = join("", data.template_file.generate_inventory.*.rendered)
  filename = "${local.workdir}/ansible-hosts"
}

