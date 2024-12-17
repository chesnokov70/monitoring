# Launch master node

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins_service_sg.id]
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

  provisioner "file" {
    source      = "./install-docker-jenkins.sh"
    destination = "/home/ubuntu/install-jenkins.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/install-jenkins.sh",
      "sudo sh /home/ubuntu/install-jenkins.sh"
    ]
  }

  tags = merge(var.common_tags, {
    Name = "${var.common_tags["Environment"]} Server Build by Terraform"
  })
}
