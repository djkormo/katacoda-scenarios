#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n beta
watch kubectl get pod -n beta
