
variable "aws_region" {
}

variable "vpc_cidr"{
description = "cidr block of the vpc"
}
variable "public_cidr"{
type = list
description = "public cidr block of the subnet"
}

variable "private_cidr"{
description = "private block of the subnet"
}
