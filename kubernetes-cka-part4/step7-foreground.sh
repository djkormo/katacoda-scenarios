#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n lambda
watch kubectl get pod -n lambda
