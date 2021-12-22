#!/bin/bash

function die() {
  echo "DIE while $1 (${BASH_SOURCE[1]}:${FUNCNAME[1]} line ${BASH_LINENO[0]})" >&2
  exit 1
}

if [[ ! -f "jenkins-cli.jar" ]]; then

  wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar > /dev/null 2>&1
  code=$?
  try=1
  while [[ $code -ne 0 ]]; do

      if [[ $try -ge 30 ]]; then
          die "wait for jenkins avaliable (timeout)"
      fi

      sleep 3
      (( try++ ))

      wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar > /dev/null 2>&1
      code=$?
  done
  
fi

sleep 5


UNAME=Admin
UPASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

function jcli() {
    java -jar jenkins-cli.jar -s http://127.0.0.1:8080 -auth $UNAME:$UPASS $@
}


if [ -n "$1" ]; then
    jcli $@ \
    || die "execute script parameters ($@)"
else

echo "--- install required plugins ---"

jcli install-plugin credentials || die "install credentials plugin"
jcli install-plugin ssh-credentials || die "install ssh-credentials plugin"
jcli install-plugin ssh-slaves || die "install ssh-slaves plugin"
jcli safe-restart || die "try to restart jenkins"

echo "--- waiting jenkins restart ---"
code=1
try=1
while [[ $code -ne 0 ]]; do

    if [[ $try -ge 30 ]]; then
        die "wait jenkins restart (timeout)"
    fi

    sleep 3
    (( try++ ))

    jcli version > /dev/null 2>&1
    code=$?
done

echo "--- import cred's, node and job to jenkins ---"

jcli import-credentials-as-xml system::system::jenkins < credentials.vagrant.xml \
|| die "import credentials"
rm -f credentials.vagrant.xml \
|| die "erase credentials"

jcli create-node < node.sbrHW-VM2.xml \
|| die "import node"
jcli create-job job.sbrHW-VM2 < job.sbrHW-VM2.xml \
|| die "import job"

jcli online-node sbrHW-VM2 \
|| die "bring node online"

sleep 10

echo "--- execute job.sbrHW-VM2 ---"
jcli build job.sbrHW-VM2 -s -v | tee job.sbrHW-VM2.log \
|| die "executing job.sbrHW-VM2"

fi


