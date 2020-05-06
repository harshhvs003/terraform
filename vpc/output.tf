output "public_subnet_out"{
value = aws_subnet.demo_vpc_public_subnet.*.id
}

output "private_subnet_out"{
value = aws_subnet.demo_vpc_private_subnet.*.id
}

