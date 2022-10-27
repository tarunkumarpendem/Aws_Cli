#!/bin/bash
#aws cli create ec2 instance
#******************************************************************************
#    AWS EC2 Instance Creation Shell Script
#******************************************************************************
#==============================================================================
#   MODIFY THE SETTINGS BELOW
#==============================================================================
REGION="us-west-2"
VPC_CIDR="10.10.0.0/16"
SUBNET_CIDR="10.10.0.0/24"
SUBNET_AZ="us-west-2a"
DESTINATION_CIDR="0.0.0.0/0"
SECURITY_GROUP_NAME="Jenkins-Sg"
PROTOCOL="tcp"
OREGON_AMI_ID="ami-0c09c7eb16d3e8e70"
INSTANCE_TYPE="t2.micro"
KEY_PAIR="standard"
INSTANCES_COUNT="1"
#==============================================================================
#   DO NOT MODIFY CODE BELOW
#==============================================================================
# Create VPC
Vpc_Id=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.VpcId' \
  --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=Jenkins_vpc}]" \
  --output text \
  --region $REGION)
echo Vpc_Id = "$Vpc_Id"  


# Create Public Subnet
Subnet_Id=$(aws ec2 create-subnet \
  --vpc-id $Vpc_Id \
  --cidr-block $SUBNET_CIDR \
  --availability-zone $SUBNET_AZ \
  --query 'Subnet.SubnetId' \
  --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Jenkins_Subnet}]" \
  --output text \
  --region $REGION)
echo Subnet_Id = "$Subnet_Id"


# create Internet Gateway
Internet_Gateway=$(aws ec2 create-internet-gateway \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=Jenkins-igw}]" \
    --output text \
    --query 'InternetGateway.InternetGatewayId' \
    --region $REGION)
echo Internet-GatewayId = "$Internet_Gateway"    


# Attach Igw to Vpc
aws ec2 attach-internet-gateway \
    --vpc-id $Vpc_Id \
    --internet-gateway-id $Internet_Gateway \
    --region $REGION
echo Vpc_Id = "$Vpc_Id"
echo Internet-GatewayId = "$Internet_Gateway"



# create Routetable
RouteTable_Id=$(aws ec2 create-route-table \
    --vpc-id $Vpc_Id \
    --region $REGION \
    --query 'RouteTable.RouteTableId' \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=Jenkins-Rt}]" \
    --output text) 
echo $RouteTable-Id = "$RouteTable_Id"    


# create route to Routetable
aws ec2 create-route \
    --route-table-id $RouteTable_Id \
    --destination-cidr-block $DESTINATION_CIDR \
    --region $REGION \
    --output text \
    --gateway-id $Internet_Gateway
echo RouteTable-Id = "$RouteTable_Id" 


# Attach subnet to Routetable
RouteTable_Association_Id=$(aws ec2 associate-route-table \
    --route-table-id $RouteTable_Id \
    --subnet-id $Subnet_Id \
    --query 'AssociationId' \
    --output text \
    --region $REGION)
echo RouteTable-Id = "$RouteTable_Id"
echo RouteTable-Association-Id = "$RouteTable_Association_Id"


# create security group 
Security_GroupId=$(aws ec2 create-security-group \
    --group-name $SECURITY_GROUP_NAME \
    --vpc-id $Vpc_Id \
    --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=Jenkins_Security_Group}]" \
    --description "For Jenkins" \
    --region $REGION \
    --output text \
    --query 'GroupId')
echo Security-GroupId = "$Security_GroupId"    
    

# creating security group inbound rules port-22(ssh)
Sg_Rule_Id1=$(aws ec2 authorize-security-group-ingress \
    --group-id $Security_GroupId \
    --region $REGION \
    --query 'SecurityGroupRules[0].SecurityGroupRuleId' \
    --protocol $PROTOCOL \
    --port "22" \
    --cidr $DESTINATION_CIDR \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_Ssh}]" \
    --output text) 
echo SSH_Sg_Id = "$Sg_Rule_Id1"


# creating security group inbound rules port-80(http)
Sg_Rule_Id2=$(aws ec2 authorize-security-group-ingress \
    --group-id $Security_GroupId \
    --region $REGION \
    --query 'SecurityGroupRules[0].SecurityGroupRuleId' \
    --protocol $PROTOCOL \
    --port "80" \
    --cidr $DESTINATION_CIDR \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_http}]" \
    --output text) 
echo HTTP_Sg_Id = "$Sg_Rule_Id2"


# creating security group inbound rules port-8080
Sg_Rule_Id3=$(aws ec2 authorize-security-group-ingress \
    --group-id $Security_GroupId \
    --region $REGION \
    --query 'SecurityGroupRules[0].SecurityGroupRuleId' \
    --protocol $PROTOCOL \
    --port "8080" \
    --cidr $DESTINATION_CIDR \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_8080}]" \
    --output text) 
echo 8080_Sg_Id = "$Sg_Rule_Id3"


# create ec2 instance
Instance_Id=$(aws ec2 run-instances \
    --image-id $OREGON_AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_PAIR \
    --security-group-ids $Security_GroupId \
    --subnet-id $Subnet_Id \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Jenkins-Cli-Instance}]" \
    --associate-public-ip-address \
    --region $REGION \
    --query 'Instances[0].InstanceId' \
    --count $INSTANCES_COUNT \
    --output text)
echo Instance-Id = "$Instance_Id" 
echo "Instance $Instance_Id is starting, go to console and stop it if you don't want to run it"   

# stop ec2 instance
#aws ec2 stop-instances \
#    --instance-ids $Instance_Id \
#    --region $REGION \
#    --output text
#echo "Instance Stopped for $Instance_Id"    



# Start ec2 instance
#aws ec2 start-instances \
#   --instance-ids $Instance_Id \
#  --region $REGION
