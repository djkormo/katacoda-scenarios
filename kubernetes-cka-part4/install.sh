#!/bin/bash

kubectl create ns alpha

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/wordpress/mysql-deployment.yaml -n alpha 

kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/wordpress/wordpress-deployment.yaml -n alpha 




