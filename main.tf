# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name         = var.image_name
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = var.num_containers

  image = docker_image.nginx.image_id
  name  = "tutorial-${count.index + 1}"
  memory = var.container_memory
  privileged = var.privileged

  ports {
    internal = 80
    external = var.starting_port + count.index
  }

  provisioner "local-exec" {
    command = <<EOT
      cp ${path.module}/index.html.tpl ${path.module}/index.html
      sed -i 's/{{HOSTNAME}}/${self.name}/g' ${path.module}/index.html
    EOT
  }

  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = "${path.module}/index.html"
  }
}

