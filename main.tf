module "vpc" {
  source               = "git::https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE.git//modules/vpc?ref=v1.1.0"
  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = var.tags
}

resource "aws_security_group" "ssm_sg" {
  name        = "${var.project_name}-${var.environment}-ssm-sg"
  description = "Security Group administrado por el orquestador. Solo permite trafico saliente para SSM."
  vpc_id      = module.vpc.vpc_id
  egress {
    description = "Permitir trafico saliente total para resolucion de SSM y parches"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-ssm-sg"
  })
}

module "ec2" {
  source             = "git::https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE.git//modules/ec2?ref=v1.1.0"
  project_name       = var.project_name
  environment        = var.environment
  purpose            = var.ec2_purpose
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [aws_security_group.ssm_sg.id]
  tags               = var.tags
}

module "s3" {
  source       = "git::https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE.git//modules/s3?ref=v1.1.0"
  project_name = var.project_name
  environment  = var.environment
  bucket_name  = var.bucket_name
  tags         = var.tags
}