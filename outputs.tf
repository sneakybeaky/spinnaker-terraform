output "spinnaker_public_ip" {
    value = "${aws_instance.spinnaker.public_ip}"
}

output "spinnaker_public_dns" {
    value = "${aws_instance.spinnaker.public_dns}"
}

output "spinnaker_key_name" {
    value = "${aws_instance.spinnaker.key_name}"
}