

gcloud projects list

export GCP_PROJECT_ID="proj-from-cli2"


gcloud config set project $GCP_PROJECT_ID
gcloud config set compute/zone us-west2-c

mkdir SS
cd SS

git clone git@github.com:apache/superset.git

cd superset


/*Ignore all below
**********************


curl -L https://github.com/kubernetes/kompose/releases/download/v1.24.0/kompose-linux-amd64 -o kompose

chmod 777 kompose

sudo mv kompose /usr/local/bin

kompose

#convert docker-compose to kompose

kompose convert


gcloud container clusters create cluster-1 --num-nodes 1 --machine-type g1-small
gcloud container clusters get-credentials cluster-1


export NAMESPACE=namespace-ss
kubectl create namespace $NAMESPACE

kubectl config set-context --current --namespace=$NAMESPACE

yamlfiles=`echo *yaml | sed s/yaml\ /yaml,/g`


kubectl apply -f $yamlfiles --namespace $NAMESPACE

kubectl get pods,deployments,services


kubectl describe svc superset-service --namespace $NAMESPACE


kubectl expose deployment superset-service --namespace $NAMESPACE --type=LoadBalancer



echo Press ENTER to close down all else press Ctrl C
read
kubectl delete pods,deployments,services --all






#kubectl run snappass --namespace $NAMESPACE --image=us.gcr.io/$GCP_PROJECT_ID/snappass:$SNAPPASS_GIT_SHA --replicas=1 --port=5000 --env="REDIS_HOST=snappass-redis" --labels="name=snappass,tier=backend,app=snappass"
#kubectl expose deployment snappass --namespace $NAMESPACE --type=ClusterIP

#kubectl expose deployment snappass-nginx --namespace $NAMESPACE --type=LoadBalancer




**************************
Till here */

curl -L https://get.helm.sh/helm-v3.7.0-rc.2-linux-amd64.tar.gz -o helm-v3.7.0-rc.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/



helm repo add superset https://apache.github.io/superset

helm search repo superset

helm upgrade --install superset superset/superset

#helm upgrade --install --values values.yaml superset superset/superset

#kubectl port-forward superset-xxxx-yyyy :8088

#kubectl expose deployment service/superset --type=LoadBalancer


kubectl patch svc superset  -p '{"spec": {"ports": [{"port": 80,"targetPort": 8088,"name": "http2"}],"type": "LoadBalancer"}}' 


kubectl get services



echo Press ENTER to close down all else press Ctrl C
read
kubectl delete pods,deployments,services --all


