Test genesis-etcd cluster:

```
ETCDCTL_API=3 etcdctl --endpoints=http://192.168.1.50:2479,http://192.168.1.51:2479,http://192.168.1.52:2479 endpoint health
http://192.168.1.52:2479 is healthy: successfully committed proposal: took = 9.207519ms
http://192.168.1.51:2479 is healthy: successfully committed proposal: took = 7.103417ms
http://192.168.1.50:2479 is healthy: successfully committed proposal: took = 17.33402ms
```