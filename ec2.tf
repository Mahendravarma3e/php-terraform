resource "aws_instance" "php_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
  }

  user_data = <<-EOF
              #!/bin/bash
              set -e  # Exit immediately if a command exits with a non-zero status

              # Log output to a file for debugging
              exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

              # Update system packages
              apt update -y && apt upgrade -y
              
              # Remove Apache if it exists
              if systemctl is-active --quiet apache2; then
                systemctl stop apache2
              fi
              if systemctl is-enabled --quiet apache2; then
                systemctl disable apache2
              fi
              apt purge -y apache2 apache2-utils apache2-bin apache2.2-common
              apt autoremove -y
              
              # Install prerequisites and add PHP repository
              apt install -y software-properties-common
              add-apt-repository -y ppa:ondrej/php
              apt update -y
              
              # Install PHP and required extensions
              apt install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring php8.2-curl php8.2-zip
              
              # Install and configure Nginx
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx

              # # Start and Enable PHP-FPM
               systemctl enable php8.2-fpm
               systemctl start php8.2-fpm

              # Configure Nginx to serve PHP
              cat <<EOL| sudo tee /etc/nginx/sites-available/default
              server {
                  listen 80 default_server;
                  listen [::]:80 default_server;

                  root /var/www/html;
                  index index.php index.html index.htm;

                  server_name _;

                  location / {
                      try_files \$uri \$uri/ =404;
                      index index.php index.html index.htm;

                      
                  }

                  location ~ \\.php\$ {
                      include snippets/fastcgi-php.conf;
                      fastcgi_pass unix:/run/php/php8.2-fpm.sock;
                      fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
                      include fastcgi_params;
                  }

                  location ~ /\\.ht {
                      deny all;
                  }
              }
              EOL
              
              # Restart Nginx to apply changes
              sudo systemctl restart nginx
              sudo systemctl restart php8.2-fpm
              
              # Create a PHP info page
              echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
EOF

  tags = {
    Name = "PHP-Ecommerce-Server"
  }
}
