.POSIX:

default:
	pulumi up -y

flush:
	pulumi stack export > stack.json
	pulumi stack import --file stack.json
	rm stack.json

destroy:
	pulumi destroy -y
