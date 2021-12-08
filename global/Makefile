default:
  pulumi up -y

flush:
  pulumi stack export > stack.json
  # jq to remove pending_operations block
  pulumi stack import --file stack.json
  rm stack.json

destroy:
  pulumi destroy -y