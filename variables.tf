# IMPORTANT: Add addon specific variables here
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
  nullable    = false
}

variable "github_runner_organization" {
  type        = string
  default     = ""
  description = "Organization to associate with the runner. Cannot be used when `github_runner_repository` is set."
  nullable    = false
}

variable "github_runner_repository" {
  type        = string
  default     = ""
  description = "Repository to associate with the runner. Cannot be used when `github_runner_organization` is set. Use `organization/repository` naming."
  nullable    = false
}

variable "github_runner_group" {
  type        = string
  default     = ""
  description = "Group to associate with the runner. See https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/managing-access-to-self-hosted-runners-using-groups"
  nullable    = false
}

variable "github_runner_labels" {
  type = list(string)
  default = [
    "self-hosted"
  ]
  description = "List of labels to associate with the runner"
  nullable    = false
}
