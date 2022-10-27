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
  --region $REGION)
echo Vpc_Id = "$Vpc_Id"  


# Create Public Subnet
Subnet_Id=$(aws ec2 create-subnet \
  --vpc-id $Vpc_Id \
  --cidr-block $SUBNET_CIDR \
  --availability-zone $SUBNET_AZ \
  --query 'Subnet.SubnetId' \
  --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Public_Subnet}]" \
  --region $REGION)
echo Subnet_Id = "$Subnet_Id"