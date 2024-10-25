
# Helm Chart: [RIMdesk Helm Chart]

## Overview

This Helm chart provides [brief description of the application or service being deployed].

## Prerequisites

- [List any prerequisites or dependencies required before deploying the Helm chart]

## Installation

To install the Helm chart, use the following command:

```bash
helm install tenant-api rimdesk-helm-chart
```

```yaml
deployment:
  name: tenant-api
  namespace: tenant-api
  replicaCount: 1
  restartPolicy: Always
  args: [ ]
  image:
    repository: tenant-api
    tag: latest
    pullPolicy: Always
  ports:
    - name: grpc
      containerPort: 50052
      protocol: TCP

service:
  name: tenant-api
  type: ClusterIP
  namespace: default
  ports:
    - port: 50052
      name: grpc
      targetPort: 50052
      protocol: TCP

resources:
  enabled: true
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi

autoscaling:
  enabled: false
  minReplicas: 1
  maxReplicas: 10

configMap:
  enabled: true
  name: tenant-api
  namespace: tenant-api
  data: { }

secrets:
  enabled: false
  namespace: default
  name: tenant-api
  data: { }

certificate:
  enabled: false
  name: "tenant-api"
  namespace: ""
  secretName: "tenant-api"
  issuerRef: ""
  commonName: ""
  dnsNames: { }

gateway:
  enabled: false
  name: ""
  namespace: ""
  specSelector: ""
  servers:
    - port:
        number: 80
        name: http
        protocol: http
      hosts:
        - "api.rimdesk.com"
    - port:
        number: 443
        name: https
        protocol: https
      hosts:
        - "api.rimdesk.com"
      tls:
        mode: SIMPLE
        credentialName: keycloak-tls

virtualService:
  enabled: true
  name: tenant-api
  gateways:
    - api-gateway
  httpRoutes:
    - name: tenant-api
      corsPolicy:
        allowHeaders:
          - authorization
          - content-type
        allowOrigins:
          exact: "*"
        allowMethods:
          - GET
          - PUT
          - POST
          - PATCH
          - DELETE
      match:
        - uri:
            prefix: ""
      route:
        - destination:
            host: ""
            port:
              number: ""
  tcpRoutes:
    - match:
        - port: 50052
      route:
        - destination:
            host: tenant-api.default.svc.cluster.local
            port:
              number: 50052
  namespace: default
  host: api.rimdesk.com

destinationRule:
  enabled: true
  name: ''
  namespace: ''
  host: ''
  trafficPolicy: { }
  portLevelSettings: { }
  subsets: { }

persistentVolume:
  enabled: false
  name: ''
  namespace: default
  labelType: ''
  storage:
    className: 'default'
    capacity: '10Gi'
  accessModes:
    - ReadWriteOnce
  hostPath: '/mnt/data'

persistentVolumeClaim:
  name: ''
  namespace: default
  enabled: false
  accessModes:
    - ReadWriteOnce
  storage: 16Gi

cronJob:
  enabled: false
  name: ""
  namespace: default
  schedule: "59 23 28-31 * *"
  failedJobsHistoryLimit: 1
  successfulJobsHistoryLimit: 3
  restartPolicy: OnFailure
  concurrencyPolicy: Forbid
  startingDeadlineSeconds: 20
  ttlSecondsAfterFinished:
  suspend: false
  parallelism: 1
  completions: 5
  activeDeadlineSeconds: 20
  completionMode: NonIndexed
  backoffLimit: 5
  backoffLimitPerIndex: ''
  containers:
    - name: hello
      image: busybox:1.28
      imagePullPolicy: IfNotPresent
      configMap:
        name: ""
      secretMap:
        name: ""
      command:
        - /bin/sh
        - -c
        - date; echo Hello from the Kubernetes cluster

argocd:
  name: 'tenant-api'
  enabled: true
  namespace: 'default'
  projectName: 'rimdesk'
  sources: [ ]
  sync:
    automated:
      prune: 'true'
      selfHeal: 'true'
    options:
      - RespectIgnoreDifferences=true
      - PruneLast=true
      - Validate=false
      - ServerSideApply=true
      - ApplyOutOfSyncOnly=true
      - CreateNamespace=true
    retry:
      limit: '2'
      backoffDuration: '5s'
      backOffMaxDuration: '3m0s'
      backOffFactor: '2'
  destination:
    name: ''
    namespace: 'tenant-api'
    server: 'https://kubernetes.default.svc'
  repository:
    url: 'https://factory24.github.io/tenant-api-helm-chart/'
    path: ''
    targetRevision: '0.1.12'
    chart: 'tenant-api-helm-chart'
    valueFiles:
      - values.yaml
  values: { }


```