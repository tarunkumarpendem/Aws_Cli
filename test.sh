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
    --query '"RouteTable.RouteTableId"' \
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









