# outputs.tf
output "container_names" {
  description = "The names of the containers"
  value       = docker_container.nginx[*].name
}

output "container_ports" {
  description = "The external ports of the containers"
  value       = [for i in range(var.num_containers) : var.starting_port + i]
}

