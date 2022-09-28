# Kustomize 101

Introduction to Kustomize

## The Basics

### Apply

```sh
kubectl apply -f app/deployment.yaml
kubectl apply -f app/service.yaml

# OR

kubectl apply -f app/
```

### Delete

```sh
kubectl delete -f app/deployment.yaml
kubectl delete -f app/service.yaml

# OR

kubectl delete -f app/
```

## The Kustomize

### Build

```sh
touch ./app/kustomization.yaml

kubectl kustomize app

# OR

kustomize build app
```

### Apply

```sh
kubectl apply -k app

# OR

kubectl kustomize app | kubectl apply -f -

# OR

kustomize build app | kubectl apply -f -
```

### Delete

```sh
kubectl delete -k app

# OR

kubectl kustomize app | kubectl delete -f -

# OR

kustomize build app | kubectl delete -f -
```

### Reference

- https://kubectl.docs.kubernetes.io/references/kustomize/builtins/

### Remind

```text
- no checksum at end of configMap & secret file name in deployment when deployment declare namespace
```
