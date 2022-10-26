aws ec2 create-vpc \
    --cidr-block "10.10.0.0/16" \
    --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=Jenkins_vpc}]" \
    --region "us-east-1" \
    --query "Vpc.VpcId"
