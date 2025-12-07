#!/bin/bash

echo "Removing application deployed with kubectl..."
kubectl delete -f manifests/

echo ""
echo "Application removed successfully!"
