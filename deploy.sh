docker build -t georgyjohn/multi-client:latest -f ./client/Dockerfile ./client
docker build -t georgyjohn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t georgyjohn/multi-server:latest -f ./server/Dockerfile ./server
docker build -t georgyjohn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t georgyjohn/multi-worker:latest -f ./worker/Dockerfile ./worker
docker build -t georgyjohn/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push georgyjohn/multi-client:latest
docker push georgyjohn/multi-server:latest
docker push georgyjohn/multi-worker:latest
docker push georgyjohn/multi-client:$SHA
docker push georgyjohn/multi-server:$SHA
docker push georgyjohn/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=georgyjohn/multi-server:$SHA
kubectl set image deployment/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployment/worker-deployment worker=georgyjohn/multi-worker:$SHA
