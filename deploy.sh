docker build -t sakipgur/multi-client:latest -t sakipgur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sakipgur/multi-server:latest -t sakipgur/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sakipgur/multi-worker:latest -t sakipgur/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sakipgur/multi-client:latest
docker push sakipgur/multi-server:latest
docker push sakipgur/multi-worker:latest

docker push sakipgur/multi-client:$SHA
docker push sakipgur/multi-server:$SHA
docker push sakipgur/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/client-deployment client=sakipgur/multi-client:$SHA
kubectl set image deployment/server-deployment server=sakipgur/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=sakipgur/multi-worker:$SHA
