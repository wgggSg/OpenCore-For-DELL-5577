# OpenCore-For-DELL-5577
&emsp;&emsp;在一次学习过程中，我有一次安装上了macOS，发现10.15.4已经装不上了......  
&emsp;&emsp;于是又开始折腾了一下，发现以前的结构太乱了，也发现Clover好像在被淘汰的路上了，于是决定彻底重构，同时尝试配置OpenCore。腾出了几天晚上的宝（游）贵（戏）的时光，经过了不懈的研究，终于基本配置成功^_^✌🏻

     OpenCore(OC)是一种新的引导方式，随着越来越多的kexts开始放弃Clover, 我相信提早使用OC会对你未来使用黑苹果会有很大的帮助。这是一个自然的现象，就像变色龙被Clover淘汰，而现在OC代替Clover也是大势所趋。（引自Xjn's Blog）
     

## 配置及改动

 硬件类型|型号
 ---- | ----- 
 笔记本型号|Dell 5577 (Inspiron 15pr-5645b)
 CPU|Intel Core i5-7300HQ（HD630）
 内存（扩容）|镁光 英睿达 8G 2400Mhz x 2
 SSD（更换）|SAMSUNG SM951 512G M.2 NVME
 HDD|西数 1T
 独显（***屏蔽***）|NVIDIA GTX1050 4G
 板载网卡|Realtek RTL8168H/8111H PCI Express Gigabit Ethernet
 无线网卡（更换）|DW1560/BCM94352z 802.11ac Wireless Network Adapter
 声卡|Realtek ALC 256
 显示屏（更换）|京东方 15.6 IPS 72色域
 
  我给电脑先后更换了不少硬件，一些硬件和DELL5577原配置有所差别，不过感觉除了网卡（***BCM94352z***），换的硬件都是对无关紧要的，同型号食用应该问题不大。

  ## 日志
  ### 2020.05.19 初次尝试配置
* 全部采用hotpatch方式修补DSDT
  * 调节亮度
  * 键盘快捷键 *降低亮度* `Fn`+`F11`, *增加亮度* `Fn`+`F12`, *休眠* `Fn`+`Insert` 等
  * x86电源管理（CPU）  
  ......
* 最小化使用Kext
  * `Lilu v1.4.4`
  * `AirportBrcmFixup v2.0.7`
  * `AppleALC v1.5.0`
  * `WhateverGreen v1.3.9`  
  ······
* 采用 `OpenCore` 引导后开关机速度会快一些，不拖泥带水
* 存在的问题（主要，其他问题待发现）
  * 耳机问题（在家里用不太到，暂时没解决）  
  * 触摸板（玄学问题，我迷茫了）  
  **Clover** 下配置明明是成功的，但是到了macOS下 `GPI0` 却不工作了，ACPI配置不起作用，我裂开
  * 电池（同上） 
  * 风扇有时狂转
  * CMOS问题（好像和开机经常自检的问题有关） 
  * win引导问题

        感谢黑果大佬们的教程及排错经验！