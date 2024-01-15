#!/usr/bin/env bash

# install packages 
yum install epel-release -y
yum install yum-utils -y
yum install vim-enhanced -y
yum install git -y

# install docker (ce버전 설치로 변경함. k8s 1.18에 맞는 버전은 < 19.03)
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce-$2 docker-ce-cli-$2 containerd.io -y && systemctl enable --now docker

# install kubernetes cluster 
yum install kubectl-$1 kubelet-$1 kubeadm-$1 -y
systemctl enable --now kubelet

# git clone _Book_k8sInfra.git 
if [ $3 = 'Main' ]; then
  git clone https://github.com/sysnet4admin/_Book_k8sInfra.git
  mv /home/vagrant/_Book_k8sInfra $HOME
  find $HOME/_Book_k8sInfra/ -regex ".*\.\(sh\)" -exec chmod 700 {} \;
fi
