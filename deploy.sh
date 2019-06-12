docker build -t vamseekrishnakattika/multi-client:latest -t vamseekrishnakattika/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vamseekrishnakattika/multi-server:latest -t vamseekrishnakattika/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vamseekrishnakattika/multi-worker:latest -t vamseekrishnakattika/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vamseekrishnakattika/multi-client:latest
docker push vamseekrishnakattika/multi-server:latest
docker push vamseekrishnakattika/multi-worker:latest

docker push vamseekrishnakattika/multi-client:$SHA
docker push vamseekrishnakattika/multi-server:$SHA
docker push vamseekrishnakattika/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=vamseekrishnakattika/multi-server:$SHA
kubectl set image deployment/client-deployment client=vamseekrishnakattika/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=vamseekrishnakattika/multi-worker:$SHA