
wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar

java -jar jenkins-cli.jar -s http://127.0.0.1:8080 -auth admin:1d289dbaa6f543e49e40dbbd06616047 $@

./jcli get-job job.sbrHW > job.sbrHW.xml
./jcli get-node sbrHW-VM2 > node.sbrHW-VM2.xml



./jcli list-credentials-as-xml system::system::jenkins
./jcli import-credentials-as-xml system::system::jenkins < cred.v2.xml



119a8f2b-0d4b-49c6-996c-ee8a3af5d653
73653fe5-5027-4c47-9dc0-34766747e955
a9e33911-7387-402e-8dfd-24a4b6115d0a
74755290-c4ff-4b7e-baa5-e5980dd12d12
ff478c73-0dcf-46de-be1b-b0efc3313e6c
2e2ff036-8446-438c-87cb-8bf39f92e57a
cf4d2356-0ab3-4a6a-97ed-703ae328718c
e8d816a1-ff6c-4699-b7ea-b2adf2d6c0cd
c74c7721-d567-43f2-90ca-b4f7a68dfe59
45d6fa99-75d7-409b-a150-dae84f228a0c