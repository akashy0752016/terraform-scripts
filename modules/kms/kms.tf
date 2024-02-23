resource "aws_kms_key" "kms_key" {
  description = var.description
  key_usage = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled = var.is_enabled
  enable_key_rotation = var.enable_key_rotation
  customer_master_key_spec = var.customer_master_key_spec
  policy = var.policy
  tags = var.tags
}
resource "aws_kms_alias" "kms_alias" {
  name = "${var.alias}/${var.name}"
  target_key_id = join("", aws_kms_key.kms_key.*.id)
}