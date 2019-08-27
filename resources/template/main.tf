# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
}

# Security group for our application.
resource "aws_security_group" "default" {
  name        = "app_security_group"
  description = "Security group for NodeJS application"
  vpc_id      = "${var.vpc_id}"

  # SSH and FTP access from anywhere
  ingress {
    from_port   = 20
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.min_ftp_port}"
    to_port     = "${var.max_ftp_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from everywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "${var.admin_user}"

    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${var.keypair_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}", "${var.agents_security_group_id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = "${aws_subnet.default.id}"
}

resource "aws_eip" "eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}
