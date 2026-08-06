output "rackula_url" {
  description = "Working URL of the Rackula web app"
  value       = "http://${module.rackula_server.public_ip}:8080"
}

output "ssm_command" {
  description = "AWS SSM command to open a session to the Rackula instance"
  value       = "aws ssm start-session --target ${module.rackula_server.id}"
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.rackula_server.id
}

output "public_ip" {
  description = "Public IP of the Rackula instance"
  value       = module.rackula_server.public_ip
}
