variable "account_principal" {
    type = string
    description = "The Account ID for the cloudwatch permission."
    default = "123456789101"    
}

variable "account_name" {
    type = string
    description = "The name of the account; used to form the statement id."
    default = "SomeAccount"
}