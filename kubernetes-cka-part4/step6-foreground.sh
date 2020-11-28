#!/bin/bash

clear
#kubectl wait --for=condition=ready pod --all -n zeta
watch kubectl get pod -n zeta
