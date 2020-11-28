#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n gamma
watch kubectl get pod -n gamma
