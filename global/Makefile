default:
  pulumi up

flush:
  pulumi stack export > stack.json
  # jq to remove pending_operations block
  pulumi stack import --file stack.json
  rm stack.json
