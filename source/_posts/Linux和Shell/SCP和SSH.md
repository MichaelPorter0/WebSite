---
title: SCP和SSH
categories: 
- [编程语言, Linux和Shell]
date: 2020-11-17 18:37:21
tags:
- Shell
---

# SCP
Linux scp 命令用于 Linux 之间复制文件和目录。

scp 是 secure copy 的缩写, scp 是 linux 系统下基于 ssh 登陆进行安全的远程文件拷贝命令。

scp 是加密的，rcp 是不加密的，scp 是 rcp 的加强版。
## 1. 向服务器拷贝文件
需要配置SSH密钥
用法：

``` bash
scp 目标文件 用户@目标服务器地址：拷贝路径/文件名
```
实例：
``` bash
scp target/ruanjian.jar ${User}@${Serve}:ruanjian.jar
```




# SSH
SSH 为 Secure Shell 的缩写，由 IETF 的网络小组（Network Working Group）所制定；SSH 为建立在应用层基础上的安全协议。SSH 是较可靠，专为远程登录会话和其他网络服务提供安全性的协议。利用 SSH 协议可以有效防止远程管理过程中的信息泄露问题。
## 1. 连接服务器
需要配置SSH密钥

用法：

``` bash
ssh 用户@目标服务器地址
```
实例：
``` bash
ssh ${User}@${Serve} 
```


## 2. 执行服务器上的shell脚本


用法：

``` bash
ssh 用户@目标服务器地址 sh 脚本文件
```
实例：
``` bash
ssh ${User}@${Serve} sh serve.sh
```

