.PHONY: up down all clean test

up:
	minikube start
	[ -n ${CI} ] && echo ${RUNNER_REGISTRATION_TOKEN} > resources/.env
	kubectl apply -k resources/
	helm repo add gitlab https://charts.gitlab.io
	helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner --version v0.53.2

down:
	helm delete --namespace default gitlab-runner
	minikube stop
