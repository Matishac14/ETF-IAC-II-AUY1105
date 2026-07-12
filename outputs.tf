output "vpc_id" {
  description = "ID de la VPC."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de subnets públicas."
  value       = module.vpc.public_subnet_ids
}

output "instance_id" {
  description = "ID de la instancia EC2."
  value       = module.ec2.instance_id
}

output "instance_ip" {
  description = "IP pública de la instancia EC2."
  value       = module.ec2.instance_ip
}

output "bucket_id" {
  description = "ID del bucket S3."
  value       = module.s3.bucket_id
}