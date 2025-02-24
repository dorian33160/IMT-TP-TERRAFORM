# variables.tf
variable "image_name" {
  description = "The Docker image to use"
  type        = string
  default     = "nginx:latest"
}

variable "container_memory" {
  description = "The amount of memory to allocate to the container"
  type        = number
  default     = 512
}

variable "privileged" {
  description = "Whether the container should run in privileged mode"
  type        = bool
  default     = false
}

variable "num_containers" {
  description = "The number of containers to spawn"
  type        = number
  default     = 3
}

variable "starting_port" {
  description = "The starting port for the containers"
  type        = number
  default     = 3000
}

