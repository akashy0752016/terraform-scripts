module "api_usage_plan_internal" {
  source = "../../modules/usage-plan"
  plan_name = "${local.name-prefix}internal"
  description = "Usage plan internal"
  rest_api_id = data.terraform_remote_state.api-gateway.outputs.rest_api_id
  deployment_stage_name = var.deployment_stage_name
  tags = local.tags
}