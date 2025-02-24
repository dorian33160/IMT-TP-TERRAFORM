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
      mkdir -p ${path.module}/html
      cp ${path.module}/index.html.tpl ${path.module}/html/index.html
      sed -i 's/{{HOSTNAME}}/${self.name}/g' ${path.module}/html/index.html
    EOT
  }

  volumes {
    container_path = "/usr/share/nginx/html"
    host_path      = "${abspath(path.module)}/html"
  }
}

