---
title: 'MarkDown基础语法'
date: 2020-09-08 17:32:50
tags:
categories: 实用工具
---
# Markdown语法

## 1.标题

类型|写法|
--|:--|
一级标题|# headings|
一级标题|## headings|
...|...|

---
## 2.字体
类型|写法|效果
--|:--|:--
斜体|一个*号包起来|*这是倾斜的文字*
加粗|两个*号包起来|**这是加粗的文字**
斜体加粗|三个*号包起来|***这是斜体加粗的文字***
删除线|两个~号包起来|~~这是加删除线的文字~~
---
## 3.引用
类型|写法|
--|:--|
引用|在引用的文字前加>即可。可以嵌套
>这是引用的内容
>>这是引用的内容
---
## 4.分割线
类型|写法|
--|:--|
分割线|三个或者三个以上的 - 或者 * 都可以。
---

## 5.列表
类型|写法|示例
--|:--|:--
无序列表| - + *与内容并列一行|- 列表内容
有序列表|数字加点|1. 列表内容
- 列表内容1
+ 列表内容2
* 列表内容3
1. 列表内容1
2. 列表内容2
3. 列表内容3
---

## 6.表格
```
表头|表头|表头
---|:--:|---
内容|内容|内容

第二行分割表头和内容。
- 有一个就行，为了对齐，多加了几个
文字默认居左
-两边加：表示文字居中
-右边加：表示文字居右
```
姓名|技能|排行
--|:--:|--:
刘备|哭|大哥
关羽|打|二哥
张飞|骂|三弟

---
## 7.代码

### 单行代码

```
`代码内容`
```
### 示例
`create database hero;`

### 代码块
```JavaScript 
    （```）{代码语言：Java..}
    代码内容
    （```）
```
### 示例
```JavaScript
    function fun(){
         echo "这是一句非常牛逼的代码";
    }
    fun();
```
---