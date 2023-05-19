# deploy-2-tier-architecture-in-aws-using-terraform

This project provides Terraform configuration files to deploy an infrastructure stack on AWS. The stack includes a VPC with subnets, an RDS MySQL database instance, and an EC2 instance running Ubuntu with Nginx and MySQL client installed.

## Table of Contents

- [Infrastructure Components](#infrastructure-components)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Infrastructure Components

The Terraform configuration files in this project will deploy the following components on AWS:

- VPC with public and private subnets
- Internet Gateway
- Default Route Table
- RDS MySQL Database Instance
- EC2 instance with Ubuntu, Nginx, and MySQL client

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- Terraform CLI installed (version ~> 1.0)
- AWS account with appropriate credentials
- AWS CLI configured with the desired AWS profile

## Installation

To deploy the infrastructure stack, follow these steps:

1. Clone the repository:

```shell
git clone https://github.com/serajushsalekin/deploy-2-tier-architecture-in-aws-using-terraform.git
cd deploy-2-tier-architecture-in-aws-using-terraform
```

2. Update the Terraform backend configuration in the `provider.tf` file. Replace the placeholder values `<s3_bucket>`, `<bucket>`, `<aws_region>`, and `<terraform_state_table>` with your AWS S3 bucket and DynamoDB table details.

3. Optionally, update the configuration variables in the `variables.tf` file to customize the deployment according to your requirements.

4. Initialize the Terraform backend and download the required provider plugins:

```shell
terraform init
```

## Configuration

Review and modify the configuration files as needed:

- `network.tf`: Defines the VPC, subnets, internet gateway, and default route table.
- `rds.tf`: Specifies the RDS MySQL database instance configuration.
- `web-server.tf`: Defines the EC2 instance configuration with Ubuntu, Nginx, and MySQL client.

Make sure to update any variables or settings according to your preferences.

## Usage

To deploy the infrastructure stack, execute the following commands:

```shell
terraform plan   # View the execution plan
terraform apply  # Deploy the infrastructure stack
```

Terraform will show you the changes it intends to make during the "plan" phase. Review the plan carefully before applying it.

After successful execution of `terraform apply`, Terraform will deploy the infrastructure stack on AWS based on the provided configuration.

## Contributing

Contributions to this project are welcome. If you encounter any issues, have suggestions, or would like to contribute improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to modify and use the code according to your needs.
