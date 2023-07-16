output "public_ip" {
  value = {
    current           = aws_instance.current.public_ip
    outdated_20210721 = aws_instance.outdated_20210721.public_ip
  }
}