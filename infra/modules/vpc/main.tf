resource "aws_vpc" "main" {

    cidr_block = var.cidr

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.env}-main"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.env}-igw"
    }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-${each.key}-${each.value.az}"
    Type = "public"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}" = "owned"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.env}-${each.key}-${each.value.az}"
    Type = "private"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/${var.env}-${var.eks_name}" = "owned"
  }
}

resource "aws_eip" "nat" {
  
  tags = {
    Name = "${var.env}-nat"
  }
}

resource "aws_nat_gateway" "nat" {

    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public["public-a"].id

    tags = {
        Name = "${var.env}-nat"
    }

    depends_on = [ aws_internet_gateway.igw ]
  
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
        Name = "${var.env}-private-rt"
    }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.env}-public-rt"
    }
  
}

resource "aws_route_table_association" "private_rta" {
    for_each = aws_subnet.private

    subnet_id = each.value.id
    route_table_id = aws_route_table.private.id
  
}

resource "aws_route_table_association" "public_rta" {
    for_each = aws_subnet.public

    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id
  
}