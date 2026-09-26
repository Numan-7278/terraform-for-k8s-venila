# aws vpc (default)
resource "aws_default_vpc" "default" {}

# aws sg
resource "aws_security_group" "k8s_sg" {
  name   = "automate_sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-cluster-sg"
  }
}



# aws instance

resource "aws_instance" "master" {
  ami           = var.ami_id
  instance_type = var.master_instance_type
  key_name      = var.key_name
  root_block_device {
    volume_size = var.storage_size
  }
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  user_data = file("master.sh")


  tags = {
    Name = "k8s-master"
    Role = "master"
  }
}

# Worker nodes
# -------------------------------------------------------
resource "aws_instance" "worker" {
  count         = var.worker_count
  ami           = var.ami_id
  instance_type = var.worker_instance_type
  key_name      = var.key_name
  root_block_device {
    volume_size = var.storage_size
  }
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  user_data = file("common.sh")

  tags = {
    Name = "k8s-worker-${count.index + 1}"
    Role = "worker"
  }
   depends_on = [aws_instance.master]
}
    