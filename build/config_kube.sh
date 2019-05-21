#!/bin/bash -e

## EKS-CI
## The following configures a CI node to run with
## AWS EKS. The following environment vars need
## to exist in CI:
##  K8S_CA_DATA
##  K8S_CLUSTER_NAME
##  K8S_ROLE_ARN
##  K8S_ENDPOINT

cat > /root/.kube/config <<EOF
apiVersion: v1
clusters:
- cluster:
    server: ${K8S_ENDPOINT}
    certificate-authority-data: ${K8S_CA_DATA}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${K8S_CLUSTER_NAME}"
        - "-r"
        - "${K8S_ROLE_ARN}"
EOF

cat > /usr/bin/helm <<"EOF"
#!/bin/bash
/usr/bin/tiller -listen 127.0.0.1:44134 -alsologtostderr -storage secret &>> /var/log/tiller.log &
# Give tiller a moment to come up
sleep 2
export HELM_HOST=127.0.0.1:44134
/usr/bin/helm-client "$@"
EXIT_CODE=$?
kill %1
exit ${EXIT_CODE}
EOF
chmod +x /usr/bin/helm
/usr/bin/helm init --client-only
