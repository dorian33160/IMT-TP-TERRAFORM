# variables.tf
variable "image_name" {
  description = "The Docker image to use"
  type        = string
  default     = "nginx:latest"

  validation {
    condition     = length(var.image_name) > 0
    error_message = "The image_name variable must not be empty."
  }
}

variable "container_memory" {
  description = "The amount of memory to allocate to the container"
  type        = number
  default     = 512

  validation {
    condition     = var.container_memory > 0
    error_message = "The container_memory variable must be greater than 0."
  }
}

variable "privileged" {
  description = "Whether the container should run in privileged mode"
  type        = bool
  default     = false
}

variable "num_containers" {
  description = "The number of containers to spawn"
  type        = number
  default     = 1

  validation {
    condition     = var.num_containers > 0
    error_message = "The num_containers variable must be greater than 0."
  }
}

variable "starting_port" {
  description = "The starting port for the containers"
  type        = number
  default     = 3000

  validation {
    condition     = var.starting_port > 0 && var.starting_port < 65536
    error_message = "The starting_port variable must be between 1 and 65535."
  }
}

