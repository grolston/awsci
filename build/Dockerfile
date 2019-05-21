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
                          awscli \
                          boto3

RUN pwsh -Command  Install-Module -Name AWSPowerShell.NetCore -Force -Confirm $false -AllowClobber

## Install IAM Authenticator
RUN curl -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator \
  &&  chmod +x /usr/bin/aws-iam-authenticator

## Install Kube
RUN mkdir -p /root/.kube
#RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
#RUN chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN  curl -o /usr/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/kubectl \
  && chmod +x /usr/bin/kubectl

## Install Helm
RUN curl -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.12.2-linux-amd64.tar.gz \
  && tar -xvf helm.tar.gz
RUN chmod +x ./linux-amd64/helm \
  && chmod +x ./linux-amd64/tiller
RUN mv ./linux-amd64/helm /usr/bin/helm-client \
  && mv ./linux-amd64/tiller /usr/bin/
RUN rm -rf ./linux-amd64/ \
  && touch /var/log/tiller.log

## Add Kube and Helm Config Script
COPY ./config_kube.sh /root/config_kube.sh
RUN chmod +x /root/config_kube.sh

CMD [ "/usr/bin/pwsh" ]