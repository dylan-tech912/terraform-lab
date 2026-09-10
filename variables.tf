variable "db_host" {
  description = "Host of the database"
  type        = string
  default     = "localhost"
}

variable "db_port" {
  description = "Host of the database"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "postgres"
}

variable "db_user" {
  description = "User used to connect to the database"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "password of the database"
  type = string
  sensitive = true
}

# variable "environment" {
#   description = "Deployment environment"
#   type        = string

#   # TODO: validate development, staging or production
# }

# variable "container_name" {
#   description = "Base name for application containers"
#   type        = string
# }

# variable "host_port" {
#   description = "First host port"
#   type        = number
# }

# variable "replicas" {
#   description = "Number of application containers"
#   type        = number
# }

# variable "memory" {
#   description = "Container memory limit in MB"
#   type        = number
# }
