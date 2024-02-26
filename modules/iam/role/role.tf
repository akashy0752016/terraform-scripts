resource "aws_iam_role" "this" {
  name = var.role-name
  assume_role_policy = file("assume_role_policy.json")
}
resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.policy-arn-list)
  role = "${aws_iam_role.this.name}"
  policy_arn = each.value
}