#####################################################################
##
##      Created 1/23/19 by admin. for poc
##
#####################################################################

output "public_ip" {
  value = "${aws_instance.awsvm.public_ip}"
}

