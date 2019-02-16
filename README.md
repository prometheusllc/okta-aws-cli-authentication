# okta-aws-cli-authentication
docker container with everything you need installed to authenticate terraform, aws cli through okta. <br />
Preqs: <br />
Docker Installed <br />
AWS Cli installed <br />


Steps:
create a file called config.properties and add the following information: <br />
#OktaAWSCLI <br />
OKTA_ORG=<add your okta organization> <br />
OKTA_AWS_APP_URL=<add the okta aws app url for the account you are logging into> <br />
OKTA_USERNAME=<add your okta username> <br />
OKTA_BROWSER_AUTH=false <br />

#you will be mounting this file along with your .aws directory to the container in a later step.


open terminal and run:

git clone https://github.com/prometheusllc/okta-aws-cli-authentication.git <br />
cd okta-aws-cli-authentication <br />
docker build -t okta-aws .
#Once the container image is built:
docker run -tid -v $HOME/.aws:/root/.aws -v  ~/.okta/config.properties:/root/.okta/config.properties --name okta-aws okta-aws
<br /><br />#Now simply run the command below to authenticate to okta <br />
#and pass in the aws cred profile name you want to use (using devops as the aws credential profile name below).<br />
docker exec -ti okta-aws  bash  -c "./getcreds.sh devops" <br />
#you should be prompted for your okta password and mfa if used.
#Once complete you should have temporary creds for the aws account you added in the OKTA_AWS_APP_URL in your ~/.aws/credentials file with a profile name of devops on your host machine <br />
#to test simply run: aws sts get-caller-identity --profile devops
