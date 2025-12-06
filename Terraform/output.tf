output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}


output "instance_id" {
  value = aws_instance.my_ec2.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.subnet1.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "route_table_id" {
  value = aws_route_table.rt.id
}

output "route_table_association_id" {
  value = aws_route_table_association.assoc.id
}

