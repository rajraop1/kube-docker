echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt-get install --assume=yes apt-transport-https ca-certificates gnupg

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

sudo apt-get update && sudo apt-get install --assume=yes google-cloud-sdk

sudo apt-get install google-cloud-sdk-app-engine-java


#kubectl

curl -LO https://dl.k8s.io/release/v1.17.15/bin/linux/amd64/kubectl -o kubectl


chmod 777 kubectl

sudo cp kubectl /usr/local/bin

