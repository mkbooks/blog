---
title: "kubefate api"           # 文章标题
author: "陈金鑫"              # 文章作者
description : "直接通过接口调用 kubefate api"    # 文章描述信息
lastmod: 2022-08-28        # 文章修改日期
date: 2022-08-28T16:27:18+08:00
categories : [              
    "kubefate",
]
tags : [                   
    "kubefate",
    "api"
]
---
# master 测试
获取服务 IP 和端口
```
k -n kube-fate get svc 
NAME       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
mariadb    ClusterIP   10.43.102.139   <none>        3306/TCP   113d
kubefate   ClusterIP   10.43.147.93    <none>        8080/TCP   113d
```
查看集群状态
```
curl 10.43.147.93:8080
{"msg":"kubefate run Success"}
curl sh.com(域名)
{"msg":"kubefate run Success"}
```
获取 token
```
curl -X POST -H 'Content-Type: application/json' -i 'http://10.43.147.93:8080/v1/user/login' --data '{
    "username": "admin",
    "password": "admin"
}'
{"code":200,"expire":"2022-08-29T07:34:13Z","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NTg0NTMsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc1NjY1M30.HIlE-j-RxufqOgS2G0n9zLnsNVWK-GdGyX1rJeX4ons"}

curl -X POST -H 'Content-Type: application/json' -i 'http://sh.com/v1/user/login' --data '{                                                                   
     "username": "admin",
     "password": "admin"
}'
{"code":200,"expire":"2022-08-29T08:10:55Z","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjA2NTUsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc1ODg1NX0.UqBvGxFnP2OgRE1t73_OBUlE-_aTaCEn99GNtAGX-2o"}
```
获取集群详情
```
curl -XGET -i 10.43.147.93:8080/v1/cluster/\?all\=false -H 'Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjA2NTUsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc1ODg1NX0.UqBvGxFnP2OgRE1t73_OBUlE-_aTaCEn99GNtAGX-2o'
```
# 在容器内访问(通过完全限定域名访问)
查看集群状态
```
curl kubefate.kube-fate:8080
{"msg":"kubefate run Success"}
```
获取 token
```
curl -X POST -H 'Content-Type: application/json' -i 'kubefate.kube-fate:8080/v1/user/login' --data '{
    "username": "admin",
    "password": "admin"
}'
{"code":200,"expire":"2022-08-29T08:58:55Z","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjM1MzUsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc2MTczNX0.T7tRQvbzVCbZfOzZZx3d00xKNbPs2_8_cUwEFAWJPUo"}
```
获取集群详情
```
curl -XGET -i kubefate.kube-fate:8080/v1/cluster/\?all\=false -H 'Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjM1MzUsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc2MTczNX0.T7tRQvbzVCbZfOzZZx3d00xKNbPs2_8_cUwEFAWJPUo'
```
获取集群详情
```
curl -XGET -i kubefate.kube-fate:8080/v1/cluster/\?all\=false -H 'Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjM1MzUsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc2MTczNX0.T7tRQvbzVCbZfOzZZx3d00xKNbPs2_8_cUwEFAWJPUo'
```
获取集群详情
```
curl -XGET -i kubefate.kube-fate:8080/v1/cluster/c610796c-e2a4-48cc-b7b3-e911cc4bb7dc -H 'Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjYwMDMsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc2NDIwM30.S5bcFEL9HURx8R9tB1A1JQFe8ggVy7vnWkzjCaSp-n0'

curl -XGET -i kubefate.kube-fate:8080/v1/cluster/566f37e0-ca8b-4627-b48c-239e494ffaec -H 'Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE3NjYwMDMsImlkIjoiYWRtaW4iLCJvcmlnX2lhdCI6MTY2MTc2NDIwM30.S5bcFEL9HURx8R9tB1A1JQFe8ggVy7vnWkzjCaSp-n0'
```