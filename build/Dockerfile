FROM centos:latest

RUN yum install epel-release -y

RUN yum install -y python36 \
                   curl \
                   python36-setuptools

RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
RUN yum install -y powershell
RUN yum clean all

RUN easy_install-3.6 pip

RUN alias python='/usr/bin/python3'

RUN pip install --upgrade pip \
                          setuptools \
                          'cfn-lint' \
                          awscli

RUN pwsh -Command  Install-Module -Name AWSPowerShell.NetCore -Force -Confirm $false -AllowClobber

## Install Kube
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

CMD [ "/usr/bin/pwsh" ]