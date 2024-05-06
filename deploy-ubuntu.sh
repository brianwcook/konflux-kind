# install golang
sudo apt-get -y install golang-go

# install podman
apt-get -y install podman

# install kind
go install sigs.k8s.io/kind@v0.22.0
cp /root/go/bin/kind /usr/local/bin/kind

# Install kubectl
cd ~
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
cp ./kubectl /usr/local/bin/

# clone konflux-ci repo
git clone https://github.com/konflux-ci/konflux-ci

# create cluster
cd /root/konflux-ci
kind create cluster --name konflux --config ./kind-config.yaml
podman update --pids-limit 4096 konflux-control-plane

# install konflux deps
cd /root/konflux-ci/
./deploy-deps.sh

# install Konflux-ci
./deploy-konflux.sh

#Deploy demo users
./deploy-test-resources.sh
