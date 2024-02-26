# HELP
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## initialize environment
	ansible-galaxy collection install -r ./requirements.yml

configure: ## configure rke cluster
	ansible-playbook -v --vault-password-file ~/.vault-password site.yml

run-k8s-role:
	ansible-playbook --vault-password-file ~/.vault-password kubernetes.yml

get-kube-config: ## download kubeconfig file
	mkdir -p ~/.kube
	ssh cloud-user@davros.jsnouff.net "sudo cat /etc/rancher/rke2/rke2.yaml" > ~/.kube/config
	sed -i 's/127.0.0.1/davros.jsnouff.net/g' ~/.kube/config

edit-vault: ## edit ansible-vault vars file
	ansible-vault edit --vault-password-file ~/.vault-password inventory/skaro/group_vars/vault.yaml

view-vault: ## view ansible-vault vars file
	ansible-vault view --vault-password-file ~/.vault-password inventory/skaro/group_vars/vault.yaml