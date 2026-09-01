variable "project_id" {
  description = "GCP project ID that owns the queue."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "project_id must be a valid GCP project ID (6-30 chars, lowercase letters, digits, hyphens)."
  }
}

variable "name" {
  description = "Name of the Cloud Tasks queue."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,100}$", var.name))
    error_message = "name must be 1-100 chars of letters, digits, hyphens or underscores."
  }
}

variable "location" {
  description = "Region the queue lives in (e.g. us-central1)."
  type        = string
  default     = "us-central1"
}

variable "max_dispatches_per_second" {
  description = "Maximum rate at which tasks are dispatched from the queue. Cap this to what the downstream worker can absorb."
  type        = number
  default     = 500

  validation {
    condition     = var.max_dispatches_per_second > 0
    error_message = "max_dispatches_per_second must be greater than 0."
  }
}

variable "max_concurrent_dispatches" {
  description = "Maximum number of tasks dispatched concurrently (in flight). Bounds load on the worker."
  type        = number
  default     = 1000

  validation {
    condition     = var.max_concurrent_dispatches > 0
    error_message = "max_concurrent_dispatches must be greater than 0."
  }
}

variable "max_attempts" {
  description = "Maximum number of attempts per task (including the first). -1 = unlimited. Bound this so a permanently-failing task does not retry forever."
  type        = number
  default     = 100

  validation {
    condition     = var.max_attempts == -1 || var.max_attempts >= 1
    error_message = "max_attempts must be -1 (unlimited) or >= 1."
  }
}

variable "max_retry_duration" {
  description = "Time limit for retrying a failed task, measured from first attempt, as a duration with the 's' suffix. \"0s\" = no overall limit (only max_attempts bounds it)."
  type        = string
  default     = "0s"

  validation {
    condition     = can(regex("^[0-9]+(\\.[0-9]+)?s$", var.max_retry_duration))
    error_message = "max_retry_duration must be a duration in seconds with the 's' suffix."
  }
}

variable "min_backoff" {
  description = "Minimum wait between retries, as a duration with the 's' suffix."
  type        = string
  default     = "0.100s"

  validation {
    condition     = can(regex("^[0-9]+(\\.[0-9]+)?s$", var.min_backoff))
    error_message = "min_backoff must be a duration in seconds with the 's' suffix, e.g. \"0.100s\"."
  }
}

variable "max_backoff" {
  description = "Maximum wait between retries, as a duration with the 's' suffix."
  type        = string
  default     = "3600s"

  validation {
    condition     = can(regex("^[0-9]+(\\.[0-9]+)?s$", var.max_backoff))
    error_message = "max_backoff must be a duration in seconds with the 's' suffix."
  }
}

variable "max_doublings" {
  description = "How many times the retry backoff interval doubles before becoming constant."
  type        = number
  default     = 16

  validation {
    condition     = var.max_doublings >= 0
    error_message = "max_doublings must be >= 0."
  }
}

variable "stackdriver_logging_sampling_ratio" {
  description = "Fraction (0.0-1.0) of task operations written to Cloud Logging. 1.0 logs everything (full observability); lower it to reduce log volume/cost."
  type        = number
  default     = 1.0

  validation {
    condition     = var.stackdriver_logging_sampling_ratio >= 0.0 && var.stackdriver_logging_sampling_ratio <= 1.0
    error_message = "stackdriver_logging_sampling_ratio must be between 0.0 and 1.0."
  }
}
