output "alb-id"{
  value = aws_lb.alb.id
}
output "targetgroup-arn"{
  value = aws_lb_target_group.alb-target-group.arn
}

