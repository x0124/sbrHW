yum update -y

yum install -y wget

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install -y epel-release java-11-openjdk-devel
yum install -y jenkins
systemctl daemon-reload


systemctl start jenkins




# -------------------------------------------------


sed -i "s/<arguments>-/<arguments>-Dfile.encoding=UTF-8 -Dpermissive-script-security.enabled=true -/"  "C:\Program Files (x86)\Jenkins/jenkins.xml"

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfwDBX5ylhn9FgjwiP+1LBvBAaXR3JSsrs2yipvNcUW2GUaCdfbUUTAfk4xsgHgkmJgvsV+hC+EbF25h+Kn8cP9XO5mMDfCh74scFRm++mBT7lv/VLp+3jdSDtjuLBUL9mZCezSsPHLvuEj2yCb5i0wn6mfWji0KHCsqUxcatEhLfWTXlOzCx6Sy9O2V2jF/Xn+0fiuP4b803dtao4S6wmZ9JbczA7yTZelEbHzWhq5HCPRqxTIRzqwE0n1UZFYxxTpwgGDW0ZhNd7ir1fJF+k91Ov6Lu/nJSa9UUGNzke70XSCvHIT+2W6Oi422L0pP7TnGsE7rqaeXhfqUL7vqat vagrant

java -Djenkins.install.runSetupWizard=false  -jar jenkins.war