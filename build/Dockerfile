FROM mcr.microsoft.com/powershell:centos-7

RUN yum install -y python36 \
                   curl \
                   python36-setuptools

RUN easy_install-3.6 pip

RUN alias python='/usr/bin/python3'

RUN pip install --upgrade pip \
                          setuptools \
                          'cfn-lint' \
                          awscli

RUN pwsh -Command Install-Module -Name AWSPowerShell.NetCore -AllowClobber

## Install Kube
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl