// Terraform CLI workspaces are associated with a specific working directory and isolate multiple state files in
//the same working directory, letting you manage multiple groups of resources with a single configuration.
//The Terraform CLI does not require you to create CLI workspaces.

## terraform workspace list ---> will show the list of workspace
## it default if no workspaces are created

terraform workspace new us-payroll  ---> to create new workspace

terraform workspace select us-payroll  ---> to switch to us-payroll

u can view the state file in terraform.tfstate.d