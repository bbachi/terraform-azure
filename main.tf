provider "azurerm" {
# The "feature" block is required for AzureRM provider 2.x.
# If you are using version 1.x, the "features" block is not allowed.
version = "~>2.0"

   subscription_id = "00000000-0000-0000-0000-000000000000"
   tenant_id = "00000000-0000-0000-0000-000000000000"
   client_id = “${data.vault_generic_secret.azure.data[“client_id”]}”
   client_secret = “${data.vault_generic_secret.azure.data[“client_secret”]}”

   features {}
   }

provider “vault” {
   address = var.vault_addr
   auth_login {
      path = “azure\\creds\\Azure-Terraform”
      parameters = {
      role_id   = "00000000-0000-0000-0000-0000000000"
      #var.login_approle_role_id
      secret_id = <your approle secret ID here>
      #var.login_approle_secret_id
      }    
   }
}

data “vault_generic_secret” “azure” {
   path = “azure\\creds\\Azure-Terraform”
}

module "vpc" {
   source = "C:\\Amazic\\Azure\\Dev\\Modules\\VPC"
   cluster_name = "Stage-LampStack"
   }

module "lamp-stack" {
   source = " C:\\Amazic\\Azure\\Dev\\Modules\\lamp"
   }
