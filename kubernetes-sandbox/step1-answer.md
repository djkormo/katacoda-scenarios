To continue you should  make your kubectl skills perfect!

Example how to start

<pre>

1. kubectl run web --image=nginx:1.11.9-alpine --port 80  -o yaml --dry-run=client > pod-web.yaml
2. kubectl apply -f pod-web.yaml
3. kubectl expose pod/web --name=webservice -n alpha

</pre>