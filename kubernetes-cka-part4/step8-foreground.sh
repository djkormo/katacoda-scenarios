#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n kappa
watch kubectl get pod -n kappa
