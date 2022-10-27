# create subnet1
aws ec2 create-subnet \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --cidr-block "10.10.0.0/24" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Subnet1}]" \
    --region "us-east-1" \
    --availability-zone "us-east-1a" \
    --query "Subnet.SubnetId"
         

# 

# create subnet2
aws ec2 create-subnet \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --cidr-block "10.10.1.0/24" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Subnet2}]" \
    --region "us-east-1" \
    --availability-zone "us-east-1b" \
    --query "Subnet.SubnetId"
