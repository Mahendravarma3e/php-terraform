resource "aws_instance" "php_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y software-properties-common
              sudo add-apt-repository ppa:ondrej/php
              sudo apt update
              sudo apt install -y php8.2
              sudo apt install -y php8.2-cli php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring php8.2-curl php8.2-zip
              apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo "<?php phpinfo(); ?>" > /var/www/html/index.php
              EOF

  tags = {
    Name = "PHP-Ecommerce-Server"
  }
}
