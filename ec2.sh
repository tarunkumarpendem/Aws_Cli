# creating security group inbound rules port-22(ssh)
aws ec2 authorize-security-group-ingress \
    --group-id "sg-051700ec3f8a3d7f9" \
    --region "us-east-1" \
    --query "SecurityGroupRules[0].SecurityGroupRuleId" \
    --protocol "tcp" \
    --port "22" \
    --cidr "0.0.0.0/0" \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_Ssh}]"



# creating security group inbound rules port-80(http)
aws ec2 authorize-security-group-ingress \
    --group-id "sg-051700ec3f8a3d7f9" \
    --region "us-east-1" \
    --query "SecurityGroupRules[0].SecurityGroupRuleId" \
    --protocol "tcp" \
    --port "80" \
    --cidr "0.0.0.0/0" \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_http}]"




# creating security group inbound rules port-8080
aws ec2 authorize-security-group-ingress \
    --group-id "sg-051700ec3f8a3d7f9" \
    --region "us-east-1" \
    --query "SecurityGroupRules[0].SecurityGroupRuleId" \
    --protocol "tcp" \
    --port "8080" \
    --cidr "0.0.0.0/0" \
    --tag-specifications "ResourceType=security-group-rule,Tags=[{Key=Name,Value=Open_8080}]"
