#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n epsilon
watch kubectl get pod -n epsilon
