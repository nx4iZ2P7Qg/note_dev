# 安装 Minikube
# https://github.com/kubernetes/minikube/releases 下载 minikube
mv minikube-linux-adm64 /usr/loal/bin/
chmod +x /usr/local/bin/minikube

# 安装 kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/darwin/amd64/kubectl

# 启动 Minikube
minikube start --registry-mirror=https://registry.docker-cn.com --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --vm-driver=none --alsologtostderr -v=8 --base-image registry.cn-hangzhou.aliyuncs.com/google_containers/kicbase:v0.0.10

# 验证状态
minikube status
