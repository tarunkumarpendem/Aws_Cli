aws ec2 create-internet-gateway \
    --region "us-east-1" \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=Jenkins-igw}]" \
    --query "InternetGateway.InternetGatewayId"
