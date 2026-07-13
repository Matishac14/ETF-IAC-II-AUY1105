# ETF-IAC-II-AUY1105 — Orquestador de Infraestructura

Repositorio **orquestador** de la Evaluación Final Transversal de la asignatura **Infraestructura como Código II (AUY1105)** — DUOC UC.

Este root module consume los módulos reutilizables publicados en [`ETF-IAC-II-AUY1105-MODULE`](https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE) y despliega una infraestructura completa en AWS bajo arquitectura **Zero Trust**, incluyendo pipeline CI/CD con análisis estático y políticas de seguridad OPA.

## Módulos utilizados

| Módulo | Versión | Fuente |
|--------|---------|--------|
| `vpc`  | `v1.1.0` | [ETF-IAC-II-AUY1105-MODULE//modules/vpc](https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE/tree/main/modules/vpc) |
| `ec2`  | `v1.1.0` | [ETF-IAC-II-AUY1105-MODULE//modules/ec2](https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE/tree/main/modules/ec2) |
| `s3`   | `v1.1.0` | [ETF-IAC-II-AUY1105-MODULE//modules/s3](https://github.com/Matishac14/ETF-IAC-II-AUY1105-MODULE/tree/main/modules/s3) |

## Requisitos

- Terraform `>= 1.9.0`
- AWS CLI configurado con credenciales válidas
- Proveedor AWS `~> 5.0`

## Variables

| Variable | Tipo | Requerida | Default                 | Descripción |
|----------|------|-------|-------------------------|-------------|
| `project_name` | `string` | No | `eft`                   | Nombre del proyecto (prefijo de recursos) |
| `environment` | `string` | No | `dev`                   | Entorno de despliegue |
| `bucket_name` | `string` | Sí | —                       | Nombre único global del bucket S3 |
| `vpc_cidr` | `string` | No | `10.1.0.0/16`           | Bloque CIDR de la VPC |
| `public_subnet_cidrs` | `list(string)` | No | `["10.1.10.0/24", ...]` | CIDRs de subnets públicas |
| `private_subnet_cidrs` | `list(string)` | No | `["10.1.20.0/24", ...]` | CIDRs de subnets privadas |
| `instance_type` | `string` | No | `t2.micro`              | Tipo de instancia EC2 |
| `ec2_purpose` | `string` | No | `web`                   | Propósito de la instancia |
| `tags` | `map(string)` | No | `{}`                    | Etiquetas globales para todos los recursos |

## Outputs

| Output | Descripción |
|--------|-------------|
| `vpc_id` | ID de la VPC creada |
| `public_subnet_ids` | IDs de las subnets públicas |
| `instance_id` | ID de la instancia EC2 |
| `instance_ip` | IP pública de la instancia EC2 |
| `bucket_id` | ID del bucket S3 |

## Uso

1. Copia el archivo de ejemplo y configura tus valores:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Inicializa los módulos y providers:
   ```bash
   terraform init
   ```

3. Revisa el plan de despliegue:
   ```bash
   terraform plan
   ```

4. Aplica la infraestructura:
   ```bash
   terraform apply
   ```

## Pipeline CI/CD

El workflow [`.github/workflows/iac-pr.yml`](.github/workflows/iac-pr.yml) se ejecuta en cada Pull Request hacia `main` con los siguientes pasos:

1. **`terraform fmt -check`** — Verifica formato del código
2. **`terraform init`** — Inicializa sin backend
3. **`TFLint`** — Análisis estático de buenas prácticas
4. **`Checkov`** — Escaneo de vulnerabilidades y configuraciones inseguras
5. **`terraform validate`** — Validación sintáctica
6. **`OPA test`** — Ejecución de políticas de seguridad en `policies/`

## Políticas de Seguridad (OPA)

Las políticas en [`policies/`](./policies/) implementan restricciones automatizadas:

| Política | Archivo | Descripción |
|----------|---------|-------------|
| Denegar SSH público | `deny_public_ssh.rego` | Bloquea Security Groups con puerto 22 abierto a `0.0.0.0/0` |
| Solo instancias t2.micro | `only_t2_micro.rego` | Restringe tipos de instancia EC2 a `t2.micro` |
| Tests de políticas | `policy_test.rego` | Valida ambas políticas en múltiples escenarios |

## Versionado

Este repositorio utiliza [Release Please](https://github.com/googleapis/release-please) para gestión automatizada de versiones con [Semantic Versioning](https://semver.org/).

Versión actual: **v1.0.2** — ver [CHANGELOG.md](./CHANGELOG.md)

## Estructura del repositorio
```bash
ETF-IAC-II-AUY1105/
.
├── CHANGELOG.md
├── README.md
├── main.tf
├── outputs.tf
├── policies
│   ├── deny_public_ssh.rego
│   ├── only_t2_micro.rego
│   └── policy_test.rego
├── providers.tf
├── release-please-config.json
├── terraform.tfvars.example
└── variables.tf

```
# Referencia repos originales con validaciones de PR manuales
- Modulo Orquestador EV1 y EV2: https://github.com/AUY1105-II/AUY1105-Grupo-4
- Modulo Orquestador EV3: https://github.com/Matishac14/AUY1105-Grupo-4