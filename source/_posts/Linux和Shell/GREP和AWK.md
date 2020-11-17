---
title: GREP和AWK命令
categories: 
- [编程语言, Linux和Shell]
date: 2020-11-17 20:37:21
tags:
- Shell
---
# GREP
Linux grep 命令用于查找文件里符合条件的字符串。

grep 指令用于查找内容包含指定的范本样式的文件，如果发现某文件的内容符合所指定的范本样式，预设 grep 指令会把含有范本样式的那一列显示出来。若不指定任何文件名称，或是所给予的文件名为 -，则 grep 指令会从标准输入设备读取数据。
grep常与其他命令混合使用
## 1. 查找某端口运行的程序

查找8080端口运行的程序
实例：
``` bash
netstat -nlp | grep :8080 
```

# AWK
AWK 是一种处理文本文件的语言，是一个强大的文本分析工具。

之所以叫 AWK 是因为其取了三位创始人 Alfred Aho，Peter Weinberger, 和 Brian Kernighan 的 Family Name 的首字符。
## 综合运用 
## 1. 终止某端口运行的程序

终止8080端口运行的程序

实例：
``` bash
kill -9 $(netstat -nlp | grep :8080 | awk '{print $7}' | awk -F"/" '{ print $1 }')
```



