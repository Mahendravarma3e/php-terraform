# RDS MySQL Instance
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20                    
  engine               = "mysql"               
  engine_version       = "8.0"                 
  instance_class       = "db.t3.micro"
  db_name              = var.db_name        
  username             = var.db_username       
  password             = var.db_password       
  parameter_group_name = "default.mysql8.0"    
  skip_final_snapshot  = true                  
  publicly_accessible  = true                  
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "RDS-MySQL"
  }
}