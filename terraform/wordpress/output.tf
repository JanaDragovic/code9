output "instance_public_ip" {
  value = "http://${aws_instance.wordpress_ec2_instance.public_ip}:80"
}
