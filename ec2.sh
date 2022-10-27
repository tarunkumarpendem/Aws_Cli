# create ec2 instance
aws ec2 run-instances \
    --image-id "ami-0149b2da6ceec4bb0" \
    --instance-type "t2.micro" \
    --key-name "standard" \
    --security-group-ids "sg-051700ec3f8a3d7f9" \
    --subnet-id "subnet-05f3deda72e32439c" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Jenkins-Cli-Instance}]" \
    --associate-public-ip-address \
    --region "us-east-1" \
    --query "Instances[0].InstanceId" \
    --count "1" \
    --user-data "sudo apt update, sudo apt install apache2 -y"
