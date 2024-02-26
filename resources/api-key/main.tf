module "api_key" {
  source = "../../modules/apikey"
  name = "${local.name-prefix}internal-key"
  description = var.description
  enable_key = true
  usage_plan_id = data.terraform_remote_state.api-usage-plan.outputs.api_usage_plan_internal
  tags = local.tags
}