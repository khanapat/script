# ArgoCD 101

Introduction to ArgoCD

## Quick Start

```sh
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30880}]'

kubectl create ns sit
```

Open [http://localhost:30880](http://localhost:30880) to access ArgoCD

Username: admin <br>
Password: (run command below)

```sh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Config ArgoCD to deploy application

```sh
kubectl apply -f app.yaml
```

## Clean up

```sh
kubectl delete -f app.yaml

kubectl delete ns sit

kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl delete ns argocd
```
