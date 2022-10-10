
/* Create new EC2 launch configuration */

resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "terraform-example-web-instance"
  image_id                    = lookup(var.amis,var.region)
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.id
  security_groups             = var.security_group
  associate_public_ip_address = false
//  user_data                   = "${data.template_file.provision.rendered}"
  iam_instance_profile        = var.test_profile

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  launch_configuration = aws_launch_configuration.launch_config.id
  min_size             = var.autoscaling_group_min_size
  max_size             = var.autoscaling_group_max_size
  target_group_arns    = var.alb_target_group_arn
  vpc_zone_identifier  = var.public_subnet_ids

  tag {
    key                 = "Name"
    value               = "terraform-autoscaling-group"
    propagate_at_launch = true
  }
}