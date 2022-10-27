# create security group 
aws ec2 create-security-group \
    --group-name "Jenkins-sg" \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=Jenkins_Security_Group}]" \
    --description "For Jenkins" \
    --region "us-east-1" \
    --query "GroupId"
