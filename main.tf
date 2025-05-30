/**
 * # AWS EKS GitHub Actions Runner Terraform module
 *
 * A Terraform module to deploy the [GitHub Actions Runner](https://github.com/lablabs/github-actions-runners-helm) on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-github-actions-runner/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-github-actions-runner/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-github-actions-runner/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-github-actions-runner/actions/workflows/pre-commit.yaml)
 */
locals {
  addon = {
    name = "github-actions-runner"

    helm_chart_name    = "github-actions-runners"
    helm_chart_version = "0.2.0"
    helm_repo_url      = "https://lablabs.github.io/github-actions-runners-helm/"
  }

  addon_irsa = {
    (local.addon.name) = {}
  }

  addon_values = jsonencode({
    organization = var.github_runner_organization
    repository   = var.github_runner_repository
    group        = var.github_runner_group
    labels       = var.github_runner_labels

    serviceAccount = {
      create = module.addon-irsa[local.addon.name].service_account_create
      name   = module.addon-irsa[local.addon.name].service_account_name
      annotations = module.addon-irsa[local.addon.name].irsa_role_enabled ? {
        "eks.amazonaws.com/role-arn" = module.addon-irsa[local.addon.name].iam_role_attributes.arn
      } : tomap({})
    }
  })

  addon_depends_on = []
}
