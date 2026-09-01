output "id" {
  description = "Fully-qualified queue ID (projects/<p>/locations/<location>/queues/<name>)."
  value       = google_cloud_tasks_queue.this.id
}

output "name" {
  description = "The queue name."
  value       = google_cloud_tasks_queue.this.name
}

output "location" {
  description = "The region the queue lives in."
  value       = google_cloud_tasks_queue.this.location
}
