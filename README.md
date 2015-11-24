# Terraform for Spinnaker

This terraform project sets up Spinnaker in an AWS account, defaulting to eu-west-1 region. This and other settings are defined as vars and so can be overridden.

## Modifying / creating a new instance

Use the standard terraform flow and make sure your AWS key is made available, e.g.

	$ export AWS_ACCESS_KEY_ID=<access_key_id>
	$ export AWS_SECRET_ACCESS_KEY=<secret_access_key>
	
## Connecting to an existing setup

Once running you have to use SSH tunneling to connect to the spinnaker instance.

Use the terraform outputs to get the details you need :

	$ terraform output
	spinnaker_key_name = spinnaker-testing
	spinnaker_public_dns = ec2-xx-xx-xx-xx.eu-west-1.compute.amazonaws.com
	spinnaker_public_ip = xx.xx.xx.xx

Edit your ~/.ssh/config with the settings from above :

	Host spinnaker
	    HostName ec2-xx-xx-xx-xx.eu-west-1.compute.amazonaws.com
	    IdentitiesOnly yes
	    IdentityFile ~/.ssh/spinnaker-testing.pem
	    LocalForward 9000 127.0.0.1:9000
	    LocalForward 8084 127.0.0.1:8084
	    LocalForward 8087 127.0.0.1:8087
	    User ubuntu

And then do

	$ ssh -f -N spinnaker

Open http://localhost:9000/ in your web browser


