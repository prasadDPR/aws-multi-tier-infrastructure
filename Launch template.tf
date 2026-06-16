resource "aws_launch_template" "private_lt" {
  name          = "private-lt"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  key_name      = var.key_name

  network_interfaces {
    security_groups = [aws_security_group.private-sg.id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo yum install -y git mysql
    git clone https://github.com/prasadDPR/website.git /home/ec2-user/website
  EOF
  )
}