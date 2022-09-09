kubectl apply -f ./mof-vault-secret.yaml -n mof-document
- create secret

kubectl get secrets -n mof-document
- list secret

kubectl describe secrets mof-vault-secret -n mof-document
- describe

kubectl get secret mof-vault-secret -o yaml -n mof-document
- check data(base64) in secret