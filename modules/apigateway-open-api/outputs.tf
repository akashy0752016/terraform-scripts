output "rest_api_id" {
  value = "${local.rest_api_id}"
}
output "execution_arn" {
  value = "${local.rest_api_execution_arn}"
}
output "invoke_url" {
  value = "${aws_api_gateway_deployment.this.invoke_url}"
}