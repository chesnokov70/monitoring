output "Grafana_URL" {
  value = "http://${aws_instance.jenkins.public_ip}:3000"
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
