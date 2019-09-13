# Install Kafka cluster

This repository installs first Zookeeper and then Kafka using *Terraform* and *Ansible*. The Terraform scripts read from Consul server where the IP and DNS addresses can be found to populate the *ansible-hosts* file.

The following Consul keys are read to identify the servers that will become Kafka brokers:

* test/master/azure/generated/[PROJECT_NAME]/private_ip_address
* test/master/azure/generated/[PROJECT_NAME]/public_dns_address
* test/master/azure/generated/[PROJECT_NAME]/public_ip_address

In theory, this code should be platform independent since only IP and DNS addresses are required to build the infrastructure.

## If no Consul available

In case you do not use Consul, the variables in file *main.tf*, in the *locals* block can be populated manually. The IP and DNS key/values take a comma separated value with no spaces. For example: *10.0.0.1,10.0.0.2,10.0.0.3*.

The *variables.tf* file should be removed since there is no read from Consul.

## Kafka configuration

The file *server.properties* is generated from ansible script. The configuration is minimal and if it is possible to configure from a Kafka project that will use the Kafka cluster then do so. Otherwise append to the file.

The configuration is also advertising a public IP address which makes it possible to access Kafka publically.
