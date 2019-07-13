docker build -t jwillemse/multi-client:latest -t jwillemse/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jwillemse/multi-server:latest -t jwillemse/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jwillemse/multi-worker:latest -t jwillemse/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jwillemse/multi-client:latest
docker push jwillemse/multi-server:latest
docker push jwillemse/multi-worker:latest
docker push jwillemse/multi-client:$SHA
docker push jwillemse/multi-server:$SHA
docker push jwillemse/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jwillemse/multi-client:$SHA
kubectl set image deployments/server-deployment server=jwillemse/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jwillemse/multi-worker:$SHA
