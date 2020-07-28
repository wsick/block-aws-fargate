# block-aws-network

Nullstone Block standing up an AWS Fargate cluster with service discovery and execution role ready for launching container services.

## Inputs

- `owner_id: string` - Stack Owner ID
- `stack_name: string` - Stack Name
- `block_name: string` - Block Name (default: `fargate0`)
- `env: string` - Environment Name
- `backend_conn_str: string` - Connection string for postgres backend

## Outputs

- `cluster_name: string`
  - Name of Fargate cluster

- `cluster_execution_role_arn: string`
  - AWS ARN for Execution Role preconfigured to run in Fargate cluster from AWS ECR (Image Registry) 

- `service_discovery_id`
  - AWS ID for Service Discovery namespace used for internal DNS service discovery registration 
