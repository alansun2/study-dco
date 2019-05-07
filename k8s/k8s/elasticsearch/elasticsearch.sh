#!/bin/sh
HAS_ELASTICSEARCH=`kubectl get pods | grep elasticsearch`
if test -n "$HAS_ELASTICSEARCH" ; then
	#statements
	kubectl delete -f /data/task/elasticsearch/elasticsearch-deployment.yml
fi
kubectl apply -f /data/task/elasticsearch/elasticsearch-deployment.yml --record
