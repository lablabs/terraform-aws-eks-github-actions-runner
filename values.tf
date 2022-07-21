locals {
  values_default = yamlencode({
    "organization" : var.github_runner_organization
    "repository" : var.github_runner_repository
    "serviceAccount" : {
      "name" : var.service_account_create ? var.service_account_name : ""
      "annotations" : {
        "eks.amazonaws.com/role-arn" : local.irsa_role_create ? aws_iam_role.this[0].arn : ""
      }
    }
    "labels" : var.github_runner_labels
  })
}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values_default,
    var.values
  ])
}
