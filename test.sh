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
  --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Public_Subnet}]" \
  --output text \
  --region $REGION)
echo Subnet_Id = "$Subnet_Id"


# create Internet Gateway
Internet_Gateway=$(aws ec2 create-internet-gateway \
    --region $REGION \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=Jenkins-igw}]" \
    --output text \
    --query "InternetGateway.InternetGatewayId)"
echo Internet-GatewayId = "$Internet_Gateway"    


# Attach Igw to Vpc
aws ec2 attach-internet-gateway \
    --vpc-id $Vpc_Id \
    --internet-gateway-id $Internet_Gateway
