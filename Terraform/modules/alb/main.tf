# Terraform configuration for Application Load Balancer (ALB)
# Security Group for ALB
resource "aws_security_group" "alb_sg" {
    name        = var.alb_sg_name
    description = var.alb_sg_description
    vpc_id      = aws_vpc.my_vpc.id
    # Inbound rules
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # Outbound rules
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.alb_sg_name}"
    }
}

# Application Load Balancer
resource "aws_lb" "my_alb" {
    name               = var.alb_name
    internal           = false
    load_balancer_type = var.alb_type
    security_groups    = [aws_security_group.my_sg.id]
    subnets            = [aws_subnet.public_subnet.id]
    
    tags = {
        Name = "${var.alb_name}"
    }
}

# Target Group for ALB
resource "aws_lb_target_group" "my_tg" {
    name     = var.target_group_name
    port     = var.target_group_port
    protocol = var.target_group_protocol
    vpc_id   = aws_vpc.my-vpc.id
    target_type = var.target_type

    health_check {
        path                = "/"
        protocol            = "HTTP"
    }

    tags = {
        Name = "${var.target_group_name}"
    }
}

# Listener for ALB
resource "aws_lb_listener" "my_listener" {
    load_balancer_arn = aws_lb.my_alb.arn
    port              = var.listener_port
    protocol          = var.listener_protocol

    default_action {
        type             = var.default_action_type
        target_group_arn = aws_lb_target_group.my_tg.arn
    }
}

# Attach EC2 instance to Target Group
resource "aws_lb_target_group_attachment" "my_tg_attachment" {
    target_group_arn = aws_lb_target_group.my_tg.arn
    target_id        = aws_instance.my_ec2.id
    port             = 80
}