#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n delta
watch kubectl get pod -n delta
