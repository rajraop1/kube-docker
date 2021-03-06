

export NAMESPACE=namespace-1


#gcloud init
gcloud projects list
export GCP_PROJECT_ID="proj-from-cli2"
gcloud config set project $GCP_PROJECT_ID
gcloud config set compute/zone us-west2-c
mkdir 3-tier
cd 3-tier/
git clone https://github.com/jameswthorne/snappass-nginx-blog-post.git


cd snappass-nginx-blog-post
openssl dhparam -out nginx_configuration/dhparam.pem 2048
mkdir ssl_certs
openssl req -new -newkey rsa:2048 -nodes -keyout ssl_certs/example.com.key -out ssl_certs/example.com.csr
openssl x509 -req -days 30 -in ssl_certs/example.com.csr -signkey ssl_certs/example.com.key -out ssl_certs/example.com.crt
git config --global user.name "Firstname Lastname"
git config --global user.email "you@example.com"
git add --all
git commit -m "Added dhparam and SSL certificates"
export SNAPPASS_NGINX_GIT_SHA=$(git rev-parse HEAD)
gcloud builds submit --tag us.gcr.io/$GCP_PROJECT_ID/snappass-nginx:$SNAPPASS_NGINX_GIT_SHA .
gcloud container images list --repository us.gcr.io/$GCP_PROJECT_ID
cd ..
git clone https://github.com/pinterest/snappass.git
cd snappass
export SNAPPASS_GIT_SHA=$(git rev-parse HEAD)
gcloud builds submit --tag us.gcr.io/$GCP_PROJECT_ID/snappass:$SNAPPASS_GIT_SHA .
gcloud container images list --repository us.gcr.io/$GCP_PROJECT_ID


#Cluster
echo Creating Cluster

gcloud container clusters create cluster-1 --num-nodes 3 --machine-type g1-small
gcloud container clusters get-credentials cluster-1


#now kubectl
kubectl create namespace $NAMESPACE 

kubectl run snappass-redis --namespace $NAMESPACE --image=redis --port=6379 --replicas=1 --labels="name=snappass-redis,tier=backend,app=snappass"
kubectl expose deployment snappass-redis --namespace $NAMESPACE --type=ClusterIP
kubectl run snappass --namespace $NAMESPACE --image=us.gcr.io/$GCP_PROJECT_ID/snappass:$SNAPPASS_GIT_SHA --replicas=1 --port=5000 --env="REDIS_HOST=snappass-redis" --labels="name=snappass,tier=backend,app=snappass"
kubectl expose deployment snappass --namespace $NAMESPACE --type=ClusterIP
kubectl run snappass-nginx --namespace $NAMESPACE --image=us.gcr.io/$GCP_PROJECT_ID/snappass-nginx:$SNAPPASS_NGINX_GIT_SHA --replicas=1 --port 443 --labels="name=snappass-nginx,tier=frontend,app=snappass"
kubectl expose deployment snappass-nginx --namespace $NAMESPACE --type=LoadBalancer

kubectl get services --namespace $NAMESPACE snappass-nginx
kubectl get pods --namespace $NAMESPACE 
kubectl get pods --namespace $NAMESPACE -l 'tier=frontend'
kubectl get pods --namespace $NAMESPACE -l 'tier=backend'
kubectl get pods --namespace $NAMESPACE -l 'app=snappass'
kubectl get deployments --namespace $NAMESPACE 
kubectl get services --namespace $NAMESPACE 
kubectl get services --namespace $NAMESPACE -l 'tier=frontend'
kubectl scale --replicas=3 --namespace $NAMESPACE deployment/snappass-nginx
kubectl scale --replicas=3 --namespace $NAMESPACE deployment/snappass
kubectl get pods --namespace $NAMESPACE -o wide
kubectl get pods --namespace $NAMESPACE 
kubectl get deployments --namespace $NAMESPACE 


kubectl get deployments --namespace $NAMESPACE  -o yaml > deployment.yaml
kubectl get services --namespace $NAMESPACE  -o yaml > services.yaml

kubectl get deployments,services,pods --namespace $NAMESPACE

#kubectl delete namespace $NAMESPACE
