# Attach subnet1 to public route table
aws ec2 associate-route-table \
    --route-table-id "rtb-0921acd3a9469b955" \
    --subnet-id "subnet-05f3deda72e32439c" \
    --query "AssociationId" \
    --region "us-east-1"  


# Attach subnet2 to private route table
aws ec2 associate-route-table \
    --route-table-id "rtb-033e8d375e1c316b0" \
    --subnet-id "subnet-03aacccb0a19f10e6" \
    --query "AssociationId" \
    --region "us-east-1"
