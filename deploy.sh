docker build -t mvsa22/multi-client:latest -t mvsa22/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mvsa22/multi-server:latest -t mvsa22/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mvsa22/multi-worker:latest -t mvsa22/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mvsa22/multi-client:latest
docker push mvsa22/multi-server:latest
docker push mvsa22/multi-worker:latest

docker push mvsa22/multi-client:$SHA
docker push mvsa22/multi-server:$SHA
docker push mvsa22/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mvsa22/multi-server:$SHA
kubectl set image deployments/client-deployment client=mvsa22/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mvsa22/multi-worker:$SHA