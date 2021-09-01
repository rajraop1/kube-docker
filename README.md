# kube-docker

A set of scripts that can be used to create docker images, push it to google cloud and use kubectl to control the deployment

File | Purpose
------------ | -------------
0-install-docker.sh.txt |  Installs Docker on Linux based
1-sample-docker-webapp.sh.txt  |     A sample Webapp running in Docker container
2-install-gcloud-kubectl.sh.txt |    Installs gcloud and then runs some kube cts
3-deploy-3-tier.sh.txt  |  Deploys a sample 3-tier application
4-SS-docker-on-glcoud.sh | General docker-compose to kompose * Not working for Superset
4-SS-docker-on-glcoud-from-site.sh | As per documentation in superset website https://superset.apache.org/docs/installation/running-on-kubernetes
