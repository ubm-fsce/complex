docker build -t uday1005/multi-client:latest -t uday1005/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t uday1005/multi-server:latest -t uday1005/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uday1005/multi-worker:latest -t uday1005/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push uday1005/multi-client:latest
docker push uday1005/multi-server:latest
docker push uday1005/multi-worker:latest
docker push uday1005/multi-client:$SHA
docker push uday1005/multi-server:$SHA
docker push uday1005/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=uday1005/multi-server:$SHA
kubectl set image deployments/client-deployment client=uday1005/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=uday1005/multi-client:$SHA

