# CREATE KIND CLUSTER
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: aline-cluster
# OPEN PORT 80 FOR NODEPORT W/HOST
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF

# APPLY AND CONFIG NGINX INGRESS CONTROLLER
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# INSTALL METALLB LOAD BALANCER
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
kubectl get pods -n metallb-system --watch
METALLB_IP_RANGE=$(docker network inspect -f '{{.IPAM.Config}}' kind 2>&1)

cat <<EOF | kubectl apply -f - 
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $METALLB_IP_RANGE
EOF

# CREATE DEV, STAGE, AND PROD NAMESPACES
cat <<EOF | kubectl apply -f - 
apiVersion: v1
kind: Namespace
metadata:
  name: dev
EOF

cat <<EOF | kubectl apply -f - 
apiVersion: v1
kind: Namespace
metadata:
  name: stage
EOF

cat <<EOF | kubectl apply -f - 
apiVersion: v1
kind: Namespace
metadata:
  name: prod
EOF