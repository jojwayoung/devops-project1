bucket_name = "dev-proj1-remote-state-bucket"
name = "environment"
environment = "dev-1"

vpc_cidr = "10.0.0.0/16"
vpc_name = "dev-proj-us-east-1-vpc-1"
cidr_public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone = ["us-east-1a", "us-east-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDdYa84NacyqbE02wlyJOcX6440hB6hMR3mghS70LvTvSTEa+7npWrRtQ43uuwS593i0q29zhe2F5/FNgEDSBzEI0DQQXMSWSZ0jrYpkCvkAh7j8G92twkm6NPDXd+tWD6Ay0sStzhtgZHoXeBoj1V597xOoTzpzjRfRQlEpTBbKweqsxI7xzlKaRNyRJUVu2aXydozYmG2HKXFYbF0nxROHC7yuvBLUtD7q/KcaL8S1i8TjMZHrIx8q8bG92gTLezICD514fdkviu1yhJc3Z4Fu8XPBYmOatSav40c+F8gdiS0Q7uiUNmqXYsNYwP5qdPJ3lM+Cgwp6TJlYuuZHG9T1n2pLP8Kk8OKhT7E1gSEEU48/Tixwe76A9zcemc7pzqOhzKO/JgZmV5zZvbHDpCaed3nJolxrk1tEyUXd14spDUHHYCu6bS3Aty/5apOwWCxGt1aXmYh43KCB/4moDgq++Zz7459Yg/3lT1qVa3Da0v9sruhnNCvmqCX9e64NMMUiscJTOiN187LMbUx/LP4dGVljKgpwrEleryHpuQjGPtMKvski3ZjXaCmWMQkOzVU8B7eR7NRf9REIK15jwzG/IwXnXkzMwKBS+AxU5hozavTcQHvekf2lAUc1/uUZDlN0e2QB7PN8RDO9XKwQ9Yckfh+TMyfzWAxVdcislaRrQ== jojwayoung421@gmail.com"
ami_id = "ami-0ec10929233384c7f"
ec2_user_data_install_apache = ""
domain_name = "dev-jwayoung.cloud"
instance_type = "t3.micro"