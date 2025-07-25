- metadata
  1. https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/object-meta/#ObjectMeta

```yaml
metadata:
  name: test-app # must be unique within a namespace
  namespace: test # the space
  labels: # map keys and values that can be used to organize and categorize objects
    app: test # map[app] = test
```

- selector
  1. https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
  2. https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#writing-a-deployment-spec
  3. https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

```yaml
spec: # deployment.yaml
  replicas: 1 # modify number of pods (default 1)
  strategy:
    type: Recreate # (terminated old and create new)

    type: RollingUpdate # (controll how to update pods)
    rollingUpdate:
      maxUnavailable: 50% # max number of pods can be unavailable during update (default 25%)
      maxSurge: 1 # max number of pods can be created during update (scale up new one then kill old one) (default 25%)
  selector: # how deployment finds pods
    matchLabels:
      app: test-app

  template:
    metadata:
      labels:
        app: test-app # must be equal selector

    spec:
      containers:
        - image: test-api:1.0.0
          imagePullPolicy: IfNotPresent # pulled only if not present

          imagePullPolicy: Always # everytime (efficient)

          imagePullPolicy: Never

          livenessProbe/readinessProbe:
            httpGet:
              path: /liveness
              port: 9090
            initialDelaySeconds: 3 # before liveness are initiated (default 0)
            periodSeconds: 3 # how often to perform (default 10)
            timeoutSeconds: 1 # default(1)
            successThreshold: 1 # must be 1 for liveness (default 1)
            failureThreshold: 1 # default(3)


      terminationGracePeriodSeconds: 60

      restartPolicy: Always

      restartPolicy: OnFailure
```

- hostname & hostAliases
  1. https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#hostname-and-name-resolution

```yaml
spec:
  template:
    spec:
      hostname: containername # host dns container name
      hostAliases: # list of hosts and ip will be in pods's hosts file
        - ip: "10.10.10.10"
          hostnames:
            - "arisebyinfinitas"
        - ip: "10.10.10.11"
          hostnames:
            - "cryptobobo"
```

- command & args

| Description                     | Docker field name | Kubernetes field name |
| ------------------------------- | ----------------- | --------------------- |
| command run by the container    | `ENTRYPOINT`      | `command`             |
| arguments passed to the command | `CMD`             | `args`                |

- port
  1. https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#ports

```yaml
spec: # service.yaml
  type: ClusterIP # expose service on cluster-internal IP(internal, default)
  # only reachable from within the cluster

  type: NodePort # expose service on each Node's IP at static port range 30000 - 32767(external)
  # external client can access by <NodeIP>:<NodePort>

  type: LoadBalancer # expose service using cloud provider's load balancer
  # standard way to expose a service to internet

  type: ExternalName # map service to content of externalName field
  # does not have selectors, use DNS names to map with a service

  type: Ingress # expose http & https routes from outside to services
  # not service type, it is reverse proxy and single entry-point

  ports: # []ContainerPort
  - name: name # unique name in pod
      protocal: TCP
      port: 9090 # internal k8s port (service port)
      targetPort: 9090 # app port (containerPort or portName in deployment)
      nodePort: 31000 # external k8s port
```

- probes

1. https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

```yaml
# The kubelet uses liveness probes to know when to restart a container.
# The kubelet uses readiness probes to know when a container is ready to start accepting traffic.
spec:
    containers:
        livenessProbe:
            exec:
                command:
                    - cat
                    - /tmp/healthy
            initialDelaySeconds: 5
            periodSeconds: 5

        livenessProbe:
            httpGet:
                path: /healthz
                port: 8080
                httpHeaders:
                    - name: Custom-Header
                      value: Awesome
            initialDelaySeconds: 3
            periodSeconds: 3
```

- env & volume

```yaml deployment
spec:
  containers:
    - name: test-pd
      env:
        - name: MESSAGE_API # env directly
          value: "BOBO"

        - name: DB_URL # env config map one key
          valueFrom:
            configMapKeyRef:
              name: configMap1
              key: DB_URL

        - name: VAULT_JWT_KEY # env kube secret one key
          valueFrom:
            secretKeyRef:
              name: secret1
              key: jwt_key # key in secret

      envFrom: # define all of configmap's data as env
        - configMapRef:
            name: configMap1

      envFrom: # define all of secretkey's data as env
        - secretRef:
            name: secret1

      volumeMounts:
        - name: config-volume
          mountPath: /app/config

        - name: persistentVolume-volume
          mountPath: /app/cert

        - name: secret-volume
          mountPath: /app/config
          readOnly: true # optional

        - name: emptydir-volume
          mountPath: /emptydir
  volumes:
    - name: config-volume # volume config map all key
      configMap:
        name: configMap1

    - name: secret-volume # volume secret
      secret:
        secretName: secret1

    - name: persistentVolume-volume # volume pvc
      persistentVolumeClaim:
        claimName: test-pvc

    - name: local-volume # volume localhost
      hostPath:
        path: /Users/arise_user/Desktop/script/kubernetes
        type: Directory # optional

    - name: emptydir-volume
      emptyDir: {}
```

```yaml persistent volume & persistent volume claim
# pv & pvc connection
apiVersion: v1
kind: PersistentVolume
metadata:
  name: hostpath-pv
  labels:
    type: hostpath
spec:
  storageClassName: hostpath
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /Users/test/path
    type: Directory

--- # with volume name
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hostpath-pvc
spec:
  resources:
    requests:
      storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  volumeName: hostpath-pv # link with pv name
--- # with selector
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hostpath-pvc
spec:
  resources:
    requests:
      storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  selector:
    matchLabels:
      type: hostpath # link with labels
```

# script

```bash
kubectl run web --image=nginx -n local

kubectl port-forward web 8088:80 -n local

kubectl exec -it <container name> sh
kubectl exec -it <pod name> -c <container name> sh

kubectl describe pods web

kubectl logs <pod name>

kubectl create configmap(cm) <map-name> <data-source>

kubectl create secret generic dbsecret --from-literal=username=appdba --from-literal=password=pazzw0rd # --from-file=dbsecret.yaml

echo "Ym9ibw==" | base64 -D # decode base64
echo "bobo" | base64 # encode base64
```

(dbsecret.yaml)

```yaml
stringData:
  password: bobo
  username: admin
```
