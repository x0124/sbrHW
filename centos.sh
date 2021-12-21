yum update -y

yum install -y wget

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install -y epel-release java-11-openjdk-devel
yum install -y jenkins
systemctl daemon-reload


systemctl enable jenkins
systemctl start jenkins

cat /var/lib/jenkins/secrets/initialAdminPassword

#sed -i '/JENKINS_JAVA_OPTIONS=/s/"$/ -Djenkins.install.runSetupWizard=false"/' /etc/sysconfig/jenkins 

#systemctl restart jenkins

# cat /var/lib/jenkins/secrets/initialAdminPassword

# -------------------------------------------------


