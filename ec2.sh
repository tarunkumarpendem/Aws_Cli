#create vpc
aws ec2 create-vpc \
    --cidr-block "10.10.0.0/16" \
    --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=Jenkins_vpc}]" \
    --region "us-east-1" \
    --query "Vpc.VpcId"
# "vpc-088ec956294cef3a5"


# create subnet1
aws ec2 create-subnet \
    --vpc-id "vpc-088ec956294cef3a5" \
    --cidr-block "10.10.0.0/24" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Subnet1}]" \
    --region "us-east-1" \
    --availability-zone "us-east-1a" \
    --query "Subnet.SubnetId"
# "subnet-0491583d91f974245"

# create subnet2
aws ec2 create-subnet \
    --vpc-id "vpc-088ec956294cef3a5" \
    --cidr-block "10.10.1.0/24" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Subnet2}]" \
    --region "us-east-1" \
    --availability-zone "us-east-1b" \
    --query "Subnet.SubnetId"

# "subnet-0fa7b0517fad0af7a"  


# create Internet Gateway
aws ec2 create-internet-gateway \
    --region "us-east-1" \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=Jenkins-igw}]" \
    --query "InternetGateway.InternetGatewayId"
# "igw-061da5154253487d4"


# Attach Igw to Vpc
aws ec2 attach-internet-gateway \
    --vpc-id "vpc-088ec956294cef3a5" \
    --internet-gateway-id "igw-0b964d23b8e8553bb"
