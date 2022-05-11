#  expectValue = "SUCCESS"
#  scriptTimeout = 10
#  replayEnabled = false
#  replayTimeout = 0
#  expectFailValue = "FAILED"

# dag_stack_name=$(aws cloudformation describe-stacks --region <REGION> | jq -r '.Stacks[] | select(.StackName | contains("<STACK NAME>-Dag")) | .StackName')
# security_group=$(aws cloudformation describe-stacks --stack-name $dag_stack_name --region <REGION> | jq -r '.Stacks[].Outputs[] | select (.OutputKey=="bigIpExternalSecurityGroup") | .OutputValue')

# echo "Security Group ID: $security_group"
# echo "Revoking Ingress rule for 1026 port on internal interface. This is done to make Active-Active"

# response=$(aws ec2 revoke-security-group-ingress --region <REGION> --group-id $security_group --protocol udp --port 1026 --source-group $security_group)

# if echo $response | grep 'error'; then
#     echo "FAILED"
# else
#     echo "SUCCESS"
# fi


firewall_rule=$(gcloud compute firewall-rules list --filter="name=('<UNIQUESTRING>-ha-fw')" --format=json | jq -r '.[0].name')

echo "Firewall Rule: $firewall_rule"
echo "Revoking Firewale Rule for 1026 port on internal interface. This is done to make Active-Active"

response=$(gcloud compute firewall-rules update <UNIQUESTRING>-ha-fw --disabled)
if [ $? -eq 0 ]; then
    echo "SUCCESS"
else
    echo "FAILED"
fi