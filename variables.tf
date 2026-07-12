variable "project_name" {
  description = "Nombre del proyecto."
  type        = string
  default     = "cheese-factory"
}

variable "environment" {
  description = "Entorno (dev, prod, etc.)."
  type        = string
  default     = "dev"
}

#Variable para el bucket S3
variable "bucket_name" {
  description = "Nombre único global del bucket S3."
  type        = string
}

#Variables para la VPC y subnets
variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC."
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subnets públicas."
  type        = list(string)
  default     = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subnets privadas."
  type        = list(string)
  default     = ["10.1.20.0/24", "10.1.21.0/24", "10.1.22.0/24"]
}

#Variables para la instancia EC2
variable "instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
  default     = "t2.micro"
}

variable "ec2_purpose" {
  description = "Propósito de la instancia (ej. web, app)."
  type        = string
  default     = "web"
}

#Variables globales para todos los recursos
variable "tags" {
  description = "Mapa de etiquetas para los recursos."
  type        = map(string)
  default     = {}
}