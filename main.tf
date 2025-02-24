# Pull the Docker image
resource "docker_image" "nginx" {
  name = var.image_name
}

# Create Docker containers
resource "docker_container" "nginx" {
  count = var.num_containers
  image = docker_image.nginx.image_id  # Use the image ID from the pulled image
  name  = "nginx-${count.index}"

  ports {
    internal = 80
    external = var.starting_port + count.index
  }

  memory = var.container_memory * 1024 * 1024  # Convert megabytes to bytes
  privileged = var.privileged

  provisioner "local-exec" {
    command = <<EOT
      echo "server { listen 80; location / { return 200 'Hostname: ${self.name}'; } }" > nginx.conf
      docker cp nginx.conf ${self.id}:/etc/nginx/conf.d/default.conf
      docker exec ${self.id} nginx -s reload
    EOT
  }
}

