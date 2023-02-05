resource "aws_lb_target_group" "target-lb" {
  name     = "target-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ram.id
}
# Creating External LoadBalancer
resource "aws_lb" "external-elb" {
  name               = "Load-Balancer"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sai_sg.id]
  subnets            = [aws_subnet.ram_pub_sun.id, aws_subnet.ram_pvt_sun.id]
}
# Attach the target group to load balaner
resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.target-lb.arn
  target_id        = aws_instance.project.id
  port             = "80"
  depends_on = [
    aws_instance.project
  ]
}
resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.target-lb.arn
  target_id        = aws_instance.project2.id
  port             = 80
  depends_on = [
    aws_instance.project2
  ]
}
resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-lb.arn
  }
}
