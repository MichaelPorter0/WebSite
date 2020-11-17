---
title: Shell脚本基础
categories: 
- [编程语言, Linux和Shell]
date: 2020-11-17 18:37:21
tags:
- Shell
---

# Shell
Shell 是一个用 C 语言编写的程序，它是用户使用 Linux 的桥梁。Shell 既是一种命令语言，又是一种程序设计语言。
## 1. 变量
定一个变量：
``` bash
User="root"
```
输出变量：
``` bash
echo ${User}
```


## 2. 数组
定义数组：
``` bash
array_name=(value0 value1 value2 value3)
```
或者：
``` bash
array_name[0]=value0
array_name[1]=value1
array_name[n]=valuen
```

## 3. 函数
定义函数：
``` bash
demoFun(){
    echo "这是我的第一个 shell 函数!"
}
echo "-----函数开始执行-----"
demoFun
echo "-----函数执行完毕-----"
```
输出：
``` bash
-----函数开始执行-----
这是我的第一个 shell 函数!
-----函数执行完毕-----
```

## 注：
shell脚本的开头通常都会有以下内容：
``` bash
#!/bin/bash
或者
#!/bin/sh
或者
#!/bin/awk
```

第一行的内容指定了shell脚本解释器的路径，而且这个指定路径只能放在文件的第一行。第一行写错或者不写时，系统会有一个默认的解释器进行解释。