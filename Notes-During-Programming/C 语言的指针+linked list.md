# C 语言的指针+linked list 

C中什么**ptr 在结合上linked list+ malloc简直是噩梦,再怎么晕人也不过分.
```text

1.!!!初值:你这个初始化怎么作?
int *ptr ;uninitialised!
int a ;
*ptr = a? not valid!
ptr = &a ;OK

2.如果你向调用函数返回双指针,那么请你使用一个*node指针,他原本就在main函数的runtimestack中. 要么干脆,传参时,headptr就是&(headnode)
原因如下:
**headptr - [addr : on stack main] - [addr of a node]
node1: [addr : on stack function] - [addr of a structure1: on heap]
一旦结束function 那么, 就会有: 
node1 被 release ! headptr points in invalid region.
!!!thus, you should return a node or *headptr.


3. linked list 结构是:
node1 - node2: [addr : on stack function] - [addr of a structure2: on heap]? NONONO! 
创建时 用malloc 返回指针 ;
这个指针已经指向完整的结构体,不需要再多座加工.
这个结构体 才是 [data :],[next:]
这个next里存了什么? 不是下一个node的地址,是:
- 下一个node的value;
- 也即下一个structure 的地址.
指针变量node和node之间没有联系. 甚至是同一个指针变量node(variable),
用一个node的地址,被一次有一次地赋值.



ps:输入法shift pinying/en 打个v也是一样.第一个v会被吞.

```

真的真的好几次了,每次都是耗时很久想不明白,都是这个Segmentation fault (core dumped) . 别再他马必的犯这个错误了.
