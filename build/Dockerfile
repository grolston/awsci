FROM mcr.microsoft.com/powershell:lts-alpine-3.10

RUN Install-Module -Name AWS.Tools.Installer -Confirm $false -Force -AllowClobber

RUN Install-AWSToolsModule AWS.Tools.EC2, \
            AWS.Tools.S3, \
            AWS.Tools.CloudFormation \
            -CleanUp

RUN apk add --update npm ruby git wget
RUN gem install cfn-nag
RUN npm install -g cfn-lint

CMD [ "/usr/bin/pwsh" ]