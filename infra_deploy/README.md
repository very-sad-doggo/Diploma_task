1. az login
2. prerequisites.sh
3. env_vars.sh
4. terraform init -backend-config=backend.tfvars
5. terraform workspace new dev
6. terraform plan
7. terraform apply


helm repo add gitlab-jh https://charts.gitlab.cn
helm install my-gitlab gitlab/gitlab \
--set certmanager-issuer.email=vladimir_ryadovoy@epam.com \
--set global.hosts.domain=local.kube.com \
--set global.hosts.externalIP=192.168.64.6 \
--version 4.10.2 \
-n gitlab