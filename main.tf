# A Cloud Tasks queue with the rate-limit and retry controls that protect a
# downstream worker from a thundering herd: a cap on dispatch rate and on
# in-flight tasks, a bounded retry policy with exponential backoff, and full
# Stackdriver logging so failed dispatches are observable instead of silent.
#
# Secure defaults: dispatch concurrency and rate are capped (not unlimited),
# retries are bounded, and operational logging is on at full sampling. Tune the
# rate limits down to match what your worker can actually absorb.

resource "google_cloud_tasks_queue" "this" {
  project  = var.project_id
  name     = var.name
  location = var.location

  rate_limits {
    max_dispatches_per_second = var.max_dispatches_per_second
    max_concurrent_dispatches = var.max_concurrent_dispatches
  }

  retry_config {
    max_attempts       = var.max_attempts
    max_retry_duration = var.max_retry_duration
    min_backoff        = var.min_backoff
    max_backoff        = var.max_backoff
    max_doublings      = var.max_doublings
  }

  stackdriver_logging_config {
    sampling_ratio = var.stackdriver_logging_sampling_ratio
  }
}
