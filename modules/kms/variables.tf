variable "name" {
  description = "Name used across resources created"
  type = string
  default = "asm"
}
variable "region" {
    type = string
    description = "The source region for an encrypted replica DB cluster"
    default = "us-east-1"
}
variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource."
  type = number
  default = 30
}
variable "description" {
  default = "KMS master key"
  type = string
  description = "The description of the key as viewed in AWS console"
}
variable "is_enabled" {
  description = "Specifies whether the kms key is enabled or disabled"
  type = bool
  default = true
}
variable "key_usage" {
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and onlt symmetric encryption and decryption are supported."
  type = string
  default = "ENCRYPT_DECRYPT"
  sensitive = true
}
variable "alias" {
  type = string
  default = "alias"
  description = "The display name of alias. The name must start with word `alias` followed by a forward slash"
}
variable "policy" {
  type = string
  default = ""
  sensitive = true
  description = "A valid policy JSON document. For more information about building AWS IAM policy documents with Terraform"
}
variable "customer_master_key_spec" {
  type = string
  default = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values; SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, pr ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
  sensitive = true
}
variable "enable_key_rotation" {
  type = bool
  default = true
  description = "Specifies whether key rotation is enabled"
}
variable "tags" {
  default = {CreatedBy = "Terraform"}
}