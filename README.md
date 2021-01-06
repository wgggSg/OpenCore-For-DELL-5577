# OpenCore-For-DELL-5577
&emsp;&emsp;在一次学习过程中，我有一次安装上了macOS，发现10.15.4已经装不上了......  
&emsp;&emsp;于是又开始折腾了一下，发现以前的结构太乱了，也发现Clover好像在被淘汰的路上了，于是决定彻底重构，同时尝试配置OpenCore。腾出了几天晚上的宝（游）贵（戏）的时光，经过了不懈的研究，终于基本配置成功^_^✌🏻

     OpenCore(OC)是一种新的引导方式，随着越来越多的kexts开始放弃Clover, 我相信提早使用OC会对你未来使用黑苹果会有很大的帮助。这是一个自然的现象，就像变色龙被Clover淘汰，而现在OC代  替Clover也是大势所趋。（引自Xjn's Blog）
     

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

## Tips *提示及注意事项*
* **UEFI** 引导项的添加  
在EFI分区下复制 `/OC` 文件夹及覆盖 `/Boot` 文件夹，引导文件为 `/Boot/Bootx64.efi`（不是类似于Clover添加`/OC/OpenCore.efi`）
* 关于 **DELL 5577** 原生 **Intel** 网卡  
目前已经有驱动 Intel 网卡的方法了，所以不换网卡也可以用 wifi 了（有需求的同学可以研究研究～ 理论上 Clover 与 OpenCore 驱动通用，只不过 OpenCore 添加驱动需要配置 `config.plist` ），但是会导致Pci-E通道被占用，所以一旦打开 Intel 的黑果 WiFi ，nvme 固态会贼卡（达芬奇跑分写入不到50m/s），尝试驱动的同学如果遇到这个问题不要被困扰（感谢`zakejune`同学提醒）

## 日志

### 2021.01.06 更新 `OpenCore` release 0.6.5 及大部分**kext**驱动版本
* 可以安装 MacOS **Big Sur**
* 驱动版本见 **/OC/Kexts/version.txt**
* 耳机插孔是可以用的
* 开机还是经常会有DELL自检问题（Memory Changed）但是不影响使用，不知道怎么解决啊啊啊qwq

### 2020.07.09 更新 `OpenCore` release 0.5.9 及部分驱动版本
* `VoodooPS2Controller` v2.1.5 添加 `Win`+`PrtScr`以关闭触摸板
* 其他驱动版本见 **/OC/Kexts/version.txt**

### 2020.06.15 完善
* 给 `ALC256` 注入新的layout id（21），可以使用耳机插孔了！！！（但耳麦不行）
* 尝试使用 `CPUFriend` 给cpu添加变频 （貌似亮屏省电效果不是很明显）

### 2020.05.30 可用于引导 Windows 10

### 2020.05.29 完善，目前体验基本与Clover一致
&emsp;&emsp;又到了久违的星期五，又抽出了宝贵的学（游）习（戏）时光看了一下上个周留下的问题，终于找到了！！果然有时刻意去解决问题是找不到解决方法的，上个周怎么也找不到的问题这个周肥肠顺利的就解决了🥳嘿嘿
* 修复触摸板 *驱动加载顺序问题*
* 修复电量显示 *添加 `ACPIBatteryManager.kext`*   
* 开机自检 *这个周重启的几次似乎没有出现过，有待观察*

      其他没有解决的问题就交给时间吧！霍霍霍

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
##
    感谢黑果大佬们的教程及排错经验！

## 扶贫
如果我的分享对你有帮助，可以请我喝肥宅快乐水来支持我！（：xiexie！！
支付宝|微信
---|---
![Catalina 2019-10-12 PM10.58.21](https://raw.githubusercontent.com/wgggSg/OpenCore-For-DELL-5577/master/Pictures/alipay.jpg)|![Catalina 2019-10-12 PM10.58.21](https://raw.githubusercontent.com/wgggSg/OpenCore-For-DELL-5577/master/Pictures/wxpay.png)