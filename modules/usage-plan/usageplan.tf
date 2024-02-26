resource "aws_api_gateway_usage_plan" "this" {
  name = var.plan_name
  description = var.description
  dynamic "quota_settings" {
    for_each = var.quota_config == null ? [] : [var.quota_config]
    content {
      limit = quota_settings.value.limit
      offset = quota_settings.value.offset
      period = quota_settings.value.period
    }
  }
  dynamic "throttle_settings" {
    for_each = var.throttle_settings == null ? [] : [var.throttle_settings]
    content {
      burst_limit = throttle_settings.value.burst_limit
      rate_limit = throttle_settings.value.rate_limit
    }
  }
  api_stages {
    api_id = var.rest_api_id
    stage = var.deployment_stage_name
  }
}