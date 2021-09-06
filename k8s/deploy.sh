docker build -t laviniapuscas/multi-client:latest -t laviniapuscas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t laviniapuscas/multi-server:latest -t laviniapuscas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t laviniapuscas/multi-worker:latest -t laviniapuscas/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push laviniapuscas/multi-client:latest
docker push laviniapuscas/multi-server:latest
docker push laviniapuscas/multi-worker:latest
docker push laviniapuscas/multi-client:$SHA
docker push laviniapuscas/multi-server:$SHA
docker push laviniapuscas/multi-worker:$SHA
kubectl apply -f k8s
kubetl set image deployments/server-deployment server=laviniapuscas/multi-server:$SHA
kubetl set image deployments/client-deployment client=laviniapuscas/multi-client:$SHA
kubetl set image deployments/worker-deployment worker=laviniapuscas/multi-worker:$SHA