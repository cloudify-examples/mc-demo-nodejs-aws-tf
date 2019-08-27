# Infrastructure: Terraform on AWS

This infrastructure blueprint creates AWS resources using Terraform.

## Prerequisites

### Plugins

* Terraform
* AWS
* [The demo plugin](../../../plugins/demo)

### Existing Resources

This blueprint assumes that the following resources are defined externally:

* VPC (use the input `vpc_id`)
* A security group that is assigned to all VM's having Cloudify Agents installed (use the input `agents_security_group_id`)

The reason for that is that the aforementioned are, in typical cases, likely to be managed
externally to any specific application.

### Terraform

The Terraform executable must be available on the Cloudify Manager machine. By default, it should exist in
`/usr/bin/terraform`; you can override this value by providing the `terraform_executable` input.

### Secrets

See [Common AWS Secrets](../README.md#common-aws-secrets) and [Common Secrets](../README.md#common-secrets) for secrets
that are assumed to exist. Note that most secrets are not required if inputs are provided.

Also:

* `terraform_plugins_dir`: Directory where Terraform plugins are located. Set this secret to an empty string in order
for plugins to be downloaded on-the-fly.
* `terraform_storage_path`: Directory to use for Terraform temporary storage. Set this secret to an empty string in order
to use the operating system's default temporary files' directory.
 