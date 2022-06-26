#!bin/bash

docker build -t trinhno/complex-client:latest -t trinhno/complex-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t trinhno/complex-server:latest -t trinhno/complex-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t trinhno/complex-worker:latest -t trinhno/complex-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push trinhno/complex-client:latest
docker push trinhno/complex-server:latest
docker push trinhno/complex-worker:latest
docker push trinhno/complex-client:$GIT_SHA
docker push trinhno/complex-server:$GIT_SHA
docker push trinhno/complex-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=trinhno/complex-client:$GIT_SHA
kubectl set image deployments/server-deployment server=trinhno/complex-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=trinhno/complex-worker:$GIT_SHA
