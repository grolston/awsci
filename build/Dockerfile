FROM mcr.microsoft.com/powershell:lts-alpine-3.10


RUN pwsh -Command 'Install-Module -Name AWS.Tools.Installer -Confirm:$false -Force -AllowClobber'

RUN pwsh -Command 'Install-AWSToolsModule AWS.Tools.EC2, AWS.Tools.S3, AWS.Tools.CloudFormation -CleanUp  -Confirm:$false -Force'

RUN apk add --update npm ruby git wget ruby-rdoc
RUN apk add ruby-webrick
RUN gem install cfn-nag
RUN npm install -g cfn-lint

# Default commands to pwsh
# ENTRYPOINT ["pwsh","-c"]

CMD [ "/usr/bin/pwsh" ]
