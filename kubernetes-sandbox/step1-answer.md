To continue you should 

Examples how to start

<pre>
1. kubectl run web --image=nginx:1.11.9-alpine --port 80  -o yaml --dry-run=client

2. kubectl expose pod/web --name=webservice -n alpha

</pre>