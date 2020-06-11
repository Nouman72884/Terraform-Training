# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_launch_configuration" "launchconfig" {
  name_prefix     = "${terraform.workspace}-launchconfig"
  image_id        = var.AMIS[var.AWS_REGION]
  instance_type   = var.AWS_INSTANCE_TYPE
  key_name        = var.KEYPAIR_NAME
  security_groups = [var.instance-security-group-id]
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt install apache2 -y
              apt install ufw -y
              ufw allow 'Apache Full'
              apt install software-properties-common -y
              sudo add-apt-repository ppa:ondrej/php -y
              apt-get update -y
              apt install php7.3 php7.3-common php7.3-opcache php7.3-cli php7.3-gd php7.3-curl php7.3-mysql -y
              systemctl restart apache2
              apt-get update -y
              apt-get upgrade -y
              apt-get install mysql-client -y
              cd /tmp
              curl -O https://wordpress.org/wordpress-5.4.tar.gz
              tar xzvf  wordpress-5.4.tar.gz
              mv /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
              sudo chown -R www-data:www-data wordpress
              sudo find wordpress/ -type d -exec chmod 750 {} \;
              sed -i -e 's/database_name_here/${var.DB_NAME}/g' /tmp/wordpress/wp-config.php
              sed -i -e 's/username_here/${var.RDS_USERNAME}/g' /tmp/wordpress/wp-config.php
              sed -i -e 's/password_here/${var.RDS_PASSWORD}/g' /tmp/wordpress/wp-config.php
              sed -i -e 's/localhost/${var.rds_endpoint}/g' /tmp/wordpress/wp-config.php
              mv wordpress/* /var/www/html/
              rm -r /var/www/html/index.html
              systemctl restart mysql
              systemctl restart apache2
              EOF
}

resource "aws_autoscaling_group" "autoscaling" {
  name                      = "${terraform.workspace}-${var.NAME}-autoscaling-group"
  vpc_zone_identifier       = var.private-subnets
  #target_group_arn          = var.targetgroup-arn
  #availability_zones        = data.aws_availability_zones.available.names
  launch_configuration      = aws_launch_configuration.launchconfig.name
  min_size                  = 1
  max_size                  = 4
  health_check_grace_period = 120
  health_check_type         = "EC2"
  default_cooldown          = 120
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "${terraform.workspace}-${var.NAME}-ec2 instance"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "autoscaling-policy-scale-up" {
  name                   = "${terraform.workspace}-${var.NAME}-autoscaling-policy-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
}
resource "aws_autoscaling_policy" "autoscaling-policy-scale-down" {
    name = "${terraform.workspace}-${var.NAME}-autoscaling-policy-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 120
    autoscaling_group_name = aws_autoscaling_group.autoscaling.name
}
resource "aws_cloudwatch_metric_alarm" "scale-up" {
  alarm_name          = "${terraform.workspace}-${var.NAME}-scle-up-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autoscaling-policy-scale-up.arn}"]
}
resource "aws_cloudwatch_metric_alarm" "scale-down" {
  alarm_name          = "${terraform.workspace}-${var.NAME}-scle-down-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.autoscaling.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autoscaling-policy-scale-down.arn}"]
}

