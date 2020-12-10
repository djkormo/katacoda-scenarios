## STEP 1

```
kubectl edit svc/frontend -n alpha
```

Change nodePort to 30001


## STEP 2

```bash
kubectl edit svc/frontend -n beta
```

Change target port to 80

## STEP 3

```bash
kubectl edit svc/frontend -n gamma
```

Change selector to

tier: frontend

## STEP 4

Have fun!

```bash
```


## STEP 5

Have fun!

```bash
```

## STEP 6

Have fun!
```bash
```

## STEP 7

Have fun!
```bash
```

## STEP 8

Have fun!
```bash
```







