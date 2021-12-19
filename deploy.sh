docker build -t 333456/multi-client:latest -t 333456/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 333456/multi-server:latest -t 333456/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 333456/multi-worker:latest -t 333456/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 333456/multi-client:latest
docker push 333456/multi-server:latest
docker push 333456/multi-worker:latest

docker push 333456/multi-client:$SHA
docker push 333456/multi-server:$SHA
docker push 333456/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=333456/multi-server:$SHA
kubectl set image deployments/client-deployment client=333456/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=333456/multi-worker:$SHA
