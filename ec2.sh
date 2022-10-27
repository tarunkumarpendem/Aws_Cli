#create vpc
aws ec2 create-vpc \
    --cidr-block "10.10.0.0/16" \
    --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=Jenkins_vpc}]" \
    --region "us-east-1" \
    --query "Vpc.VpcId" 
  
# "vpc-0f207b88b749c6d1d"


# create subnet1
aws ec2 create-subnet \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --cidr-block "10.10.0.0/24" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Subnet1}]" \
    --region "us-east-1" \
    --availability-zone "us-east-1a" \
    --query "Subnet.SubnetId"      

# "subnet-05f3deda72e32439c"

# create subnet2
aws ec2 create-subnet \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --cidr-block "10.10.1.0/24" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Subnet2}]" \
    --region "us-east-1" \
    --availability-zone "us-east-1b" \
    --query "Subnet.SubnetId"
           
# "subnet-03aacccb0a19f10e6"  


# create Internet Gateway
aws ec2 create-internet-gateway \
    --region "us-east-1" \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=Jenkins-igw}]" \
    --query "InternetGateway.InternetGatewayId"
# "igw-09379178181ddbd46"


# Attach Igw to Vpc
aws ec2 attach-internet-gateway \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --internet-gateway-id "igw-09379178181ddbd46"


# create public route table
aws ec2 create-route-table \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --region "us-east-1" \
    --query "RouteTable.RouteTableId" \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Pub-rt}]" 
# "rtb-0921acd3a9469b955"


# create private route table
aws ec2 create-route-table \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --region "us-east-1" \
    --query "RouteTable.RouteTableId" \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Pvt-rt}]"  
# "rtb-033e8d375e1c316b0"


# create route to public route table
aws ec2 create-route \
    --route-table-id "rtb-0921acd3a9469b955" \
    --destination-cidr-block "0.0.0.0/0" \
    --region "us-east-1" \
    --gateway-id "igw-09379178181ddbd46"


# Attach subnet1 to public route table
aws ec2 associate-route-table \
    --route-table-id "rtb-0921acd3a9469b955" \
    --subnet-id "subnet-05f3deda72e32439c" \
    --query "AssociationId" \
    --region "us-east-1" 
# "rtbassoc-09ab3a8d47a761dae"    



# Attach subnet2 to private route table
aws ec2 associate-route-table \
    --route-table-id "rtb-033e8d375e1c316b0" \
    --subnet-id "subnet-03aacccb0a19f10e6" \
    --query "AssociationId" \
    --region "us-east-1"
# "rtbassoc-08055b582cab6aa9c"


# create security group 
aws ec2 create-security-group \
    --group-name "Jenkins-sg" \
    --vpc-id "vpc-0f207b88b749c6d1d" \
    --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=Jenkins_Security_Group}]" \
    --description "For Jenkins" \
    --region "us-east-1" \
    --query "GroupId"
# "sg-051700ec3f8a3d7f9"


# creating security group inbound rules port-22(ssh)
aws ec2 authorize-security-group-ingress \
    --group-id "sg-051700ec3f8a3d7f9" \
    --region "us-east-1" \
    --query "SecurityGroupRules[0].SecurityGroupRuleId" \
    --protocol "tcp" \
    --port "22" \
    --cidr "0.0.0.0/0" \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_Ssh}]"
# "sgr-06b0425f416826cb9"


# creating security group inbound rules port-80(http)
aws ec2 authorize-security-group-ingress \
    --group-id "sg-051700ec3f8a3d7f9" \
    --region "us-east-1" \
    --query "SecurityGroupRules[0].SecurityGroupRuleId" \
    --protocol "tcp" \
    --port "80" \
    --cidr "0.0.0.0/0" \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_http}]"
# "sgr-0dc3dda86da2ed356"



# creating security group inbound rules port-8080
aws ec2 authorize-security-group-ingress \
    --group-id "sg-051700ec3f8a3d7f9" \
    --region "us-east-1" \
    --query "SecurityGroupRules[0].SecurityGroupRuleId" \
    --protocol "tcp" \
    --port "8080" \
    --cidr "0.0.0.0/0" \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_8080}]"
# "sgr-0ec61c209feef4d71"


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
    --count "1" 
# "i-071a5d5e2eda6e553"


# stop ec2 instance
aws ec2 stop-instances \
    --instance-ids "i-071a5d5e2eda6e553" \
    --region "us-east-1"



# Start ec2 instance
aws ec2 start-instances \
    --instance-ids "i-071a5d5e2eda6e553" \
    --region "us-east-1"
