package:
	helm package base
	helm repo index .

lint:
	helm lint base

template:
	helm template rimdesk-helm-chart base --values base/values.yaml

bundle:
	make lint
	make template
	make package