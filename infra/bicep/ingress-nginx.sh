git clone https://github.com/nginxinc/kubernetes-ingress.git
cd kubernetes-ingress

kubectl apply -f deployments/common/ns-and-sa.yaml
kubectl apply -f deployments/rbac/rbac.yaml

kubectl apply -f examples/shared-examples/default-server-secret/default-server-secret.yaml
kubectl apply -f deployments/common/nginx-config.yaml
kubectl apply -f deployments/common/ingress-class.yaml

kubectl apply -f config/crd/bases/k8s.nginx.org_virtualservers.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_transportservers.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_policies.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_globalconfigurations.yaml

kubectl apply -f deployments/deployment/nginx-ingress.yaml

kubectl apply -f deployments/service/loadbalancer.yaml

kubectl get pods --namespace=nginx-ingress

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


cd ..
kubectl apply -f ./echo.kube.yaml

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

echo "\n"

kubectl -n argocd patch service argocd-server -p '{"spec": {"type": "LoadBalancer"}}'
