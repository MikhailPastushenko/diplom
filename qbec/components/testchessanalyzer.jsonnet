local p = import '../params.libsonnet';
local params = p.components.testchessanalyzer;
local env = {
  namespace: std.extVar('qbec.io/env'),
};
local imageTag = std.extVar('image_tag');


[
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app.kubernetes.io/component": params.name,
      "app.kubernetes.io/name": params.name
    },
    "name": params.name,
    "namespace": env.namespace
  },
  "spec": {
    "replicas": 3,
    "selector": {
      "matchLabels": {
        "app.kubernetes.io/component": params.name,
        "app.kubernetes.io/name": params.name
      }
    },
    "template": {
      "metadata": {
        "labels": {
         "app.kubernetes.io/component": params.name,
         "app.kubernetes.io/name": params.name
        }
      },
      "spec": {
        "containers": [
          {
            "env": null,
            "image": params.image + ':' + imageTag,
            "name": params.name,
            "ports": [
              {
                "containerPort": params.ports.containerPort,
                "protocol": "TCP"
              }
            ]
          }
        ]
      }
    }
  }
},

{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "labels": {
      "app.kubernetes.io/component": params.name,
      "app.kubernetes.io/name": params.name
    },
    "name": params.name,
    "namespace": env.namespace
  },
  "spec": {
    "type": "LoadBalancer",
    "ports": [
      {
        "name": "web",
          "protocol": "TCP",
          "port": params.service.port,
          "targetPort": params.ports.containerPort
      }
    ],
    "selector": {
        "app.kubernetes.io/component": params.name,
        "app.kubernetes.io/name": params.name
    }
  }
},
{
  "apiVersion": "networking.k8s.io/v1",
  "kind": "Ingress",
  "metadata": {
    "name": "http-ingress",
    "annotations": {
      "kubernetes.io/ingress.class": "nginx",
      "ingress.alb.yc.io/external-ipv4-address": "51.250.36.198"
    }
  },
  "spec": {
    "rules": [
      {
        "http": {
          "paths": [
            {
              "path": "/",
              "pathType": "Prefix",
              "backend": {
                "service": {
                  "name": params.name,
                  "port": {
                    "number": 9000
                  }
                }
              }
            }
          ]
        }
      }
    ]
  }
}
]

