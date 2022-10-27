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
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.{VpcId:VpcId}' \
  --tag-specification "ResourceType=vpc,Tags=[{Key=Name,Value=Jenkins_vpc}]" \
  --region $REGION)
echo Vpc_Id = "$VPC_ID"  


# Create Public Subnet
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_CIDR \
  --availability-zone $SUBNET_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=Public_Subnet}]" \
  --region $REGION)
echo Subnet_Id = "$SUBNET_ID"