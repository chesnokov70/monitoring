# Launch master node

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.node_exp_service_sg.id]
  monitoring             = var.enable_detailed_monitoring
#  iam_instance_profile = aws_iam_instance_profile.jenkins_profile_devops_en.name
  key_name               = "ssh_aws_key"  # Specify your key pair name here


  root_block_device {
    volume_size = 25
  }

      # Add connection block for remote-exec
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("~/.ssh/ssh_aws_key.pem")  # Update the path to your private key file
    }

 provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl enable --now docker",
      "docker run -d --name=node_exporter --restart=always -p 9100:9100 quay.io/prometheus/node-exporter:latest"
    ]
  }

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]} Node_exporter Server"
  })
}

