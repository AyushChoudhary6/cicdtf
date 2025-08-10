output "pb_sn" {
  value = aws_subnet.pb_sbnet.id
}

output "sg_id" {
  value = aws_security_group.sg.id
}

