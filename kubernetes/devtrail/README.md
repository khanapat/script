# k8s

```cli
kubectl config get-contexts

kubectl config use-context $(AUTHINFO)

kubectl get pods -n $(NAMESPACE)

kubectl get svc -n $(NAMESPACE)

kubectl get secret $(SECRET) -o yaml -n $(NAMESPACE)

kubectl describe pods $(POD) -n $(NAMESPACE)

kubectl logs -f $(POD) -n $(NAMESPACE)

kubectl get pv,pvc -n $(NAMESPACE)

kubectl apply -f $(DEPLOYMENT,SERVICE) -n $(NAMESPACE)

kubectl patch pvc ersistentvolumeclaim/$(PVC) -p ‘{“spec”:{“claimRef”: null}}’
```

## PORT

```yaml
# service.yaml
# nodeport
type: NodePort
ports: # []ContainerPort
  - name: api # unique name in pod
    protocal: TCP
    port: 9090 # internal k8s port (service port)
    targetPort: 9090 # app port (containerPort or portName in deployment,pod)
    nodePort: 31000 # external k8s port
```

```yaml
# clusterip
type: ClusterIP
ports:
  - name: api
    protocol: TCP
    port: 8080
    targetPort: 80
```

```yaml
# loadbalancer
type: LoadBalancer
ports:
  - name: http
    protocol: TCP
    port: 9090
    targetPort: 9090
```

## RESOURCE

```yaml
# deployment.yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

## PROBE

```yaml
# deployment.yaml
# http
livenessProbe:
  httpGet:
    path: /liveness
    port: 9090
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
readinessProbe:
  httpGet:
    path: /readiness
    port: 9090
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 3
```

```yaml
# deployment.yaml
# command
livenessProbe:
  exec:
    command:
      - /bin/sh
      - -c
      - pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} -p 5432
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
readinessProbe:
  exec:
    command:
      - /bin/sh
      - -c
      - pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB} -p 5432
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 3
```

## ENV

```yaml
# deployment.yaml
# from configmap or secret or env
env:
  - name: NODE_ENV
    value: "production"
  - name: LOG_LEVEL
    valueFrom:
      configMapKeyRef:
        name: backend-configmap
        key: LOG_LEVEL
  - name: POSTGRES_URL
    valueFrom:
      secretKeyRef:
        name: arisepreq-secret
        key: postgres_url
  - name: POSTGRES_TIMEOUT
    valueFrom:
      configMapKeyRef:
        name: backend-configmap
        key: POSTGRES_TIMEOUT
```

```yaml
containers:
  - name: k6-job
    image: grafana/k6:latest
    imagePullPolicy: Always
    env:
      - name: BASE_URL
        value: http://34.143.237.220:9090
    command: ["k6"]
    args:
      [
        "run",
        "/challenge/k6/01-api-apply-loans.test.js",
        "--env",
        "BASE_URL=$(BASE_URL)",
      ]
```

## MOUNT

```yaml
# deployment.yaml
# init database volume
    volumeMounts:
      - name: postgres-init-volume
        mountPath: /docker-entrypoint-initdb.d
volumes:
  - name: postgres-init-volume
    configMap:
      name: postgres-configmap
```

```yaml
# deployment.yaml
# store data volume
    volumeMounts:
      - name: postgres-data-volume
        mountPath: /var/lib/postgresql/data
volumes:
  - name: postgres-data-volume
    persistentVolumeClaim:
      claimName: postgres-pvc
```

```yaml
# pv.yaml
# host path
spec:
  storageClassName: manual
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
  hostPath: # absolute path to the host directory
    path: ${PWD}/scripts/database/docker-entrypoint-initdb.d
```

## SECRET

```yaml
# secret.yaml
# data plaintext
type: Opaque
stringData:
  postgres_url: postgres://username:P@ssw0rd@postgres-service.arisepreq.svc.cluster.local:5432/arisepreq?sslmode=disable
  postgres_name: arisepreq
```

```yaml
# secret.yaml
# data base64
type: Opaque
data:
  postgres_url: cG9zdGdyZXM6Ly91c2VybmFtZTpQQHNzdzByZEBwb3N0Z3Jlcy1zZXJ2aWNlLmFyaXNlcHJlcS5zdmMuY2x1c3Rlci5sb2NhbDo1NDMyL2FyaXNlcHJlcT9zc2xtb2RlPWRpc2FibGU=
  postgres_name: YXJpc2VwcmVx
```
