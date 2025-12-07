#!/bin/bash

echo "Deploying ingress"

./deploy-ingress.sh

echo "Deploying application using kubectl..."
kubectl apply -f manifests/

echo ""
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=backend --timeout=120s
kubectl wait --for=condition=ready pod -l app=frontend --timeout=120s

echo ""
echo "Application deployed successfully!"
echo ""
echo "Check status:"
echo "  kubectl get pods"
echo "  kubectl get services"
echo "  kubectl get ingress main-ingress"
echo ""
echo "Get external IP:"
echo "  kubectl get ingress main-ingress"
