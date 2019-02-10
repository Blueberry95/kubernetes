#!/bin/bash
echo "creating deployment from yaml file"
kubectl create -f nastya_deploy_v1.yaml
echo
echo
echo "scaling deployment to 4 pods"
kubectl scale --replicas=4 deployment/nastya-deployment
kubectl get pods
echo
echo
echo "scaling back deployment to 2 pods"
kubectl scale --replicas=2 deployment/nastya-deployment
kubectl get pods
echo
echo
echo "upgrading nginx image"
kubectl set image deployment/nastya-deployment nginx-nastya=nginx:1.13.8
echo
echo
echo "Check the status of the upgrade"
kubectl rollout status deployment/nastya-deployment
echo
echo
echo "Check deployment history"
kubectl rollout history deployment/nastya-deployment
echo
echo
echo "comming back to previous deployment"
kubectl rollout undo deployment/nastya-deployment
echo 
echo
echo "to comeback to any version use: kubectl rollout undo deployment/nastya-deployment --to-revision=[any_number]"
echo
echo
echo "creating loadbalancer service"
kubectl create -f loadbalancer.yaml
echo
echo
echo "scales when CPU usage is over 50%"
kubectl autoscale deployment.v1.apps/nastya-deployment --min=2 --max=15 --cpu-percent=50
