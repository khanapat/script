#!/bin/bash

kubectl exec -it $(kubectl get pods -n test | grep postgres | awk '{print $1}') -n test \
  -- bash -c 'createdb -h localhost -p 5432 -U postgres konga'