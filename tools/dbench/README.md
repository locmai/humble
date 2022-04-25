## Benchmark Kubernetes persistent disk volumes

Benchmark Kubernetes persistent disk volumes with fio (based on https://github.com/leeliu/dbench). For persistent volume provisioner comparison.

```
kubectl apply -f ./tools/dbench/dbench-longhorn.yaml
persistentvolumeclaim/dbench-pv-claim-longhorn created
job.batch/dbench-longhorn created
.
.
.
.
All tests complete.

==================
= Dbench Summary =
==================
Random Read/Write IOPS: 18.3k/6648. BW: 215MiB/s / 43.8MiB/s
Average Latency (usec) Read/Write: 528.77/908.04
Sequential Read/Write: 208MiB/s / 63.2MiB/s
Mixed Random Read/Write IOPS: 5530/1851
```
