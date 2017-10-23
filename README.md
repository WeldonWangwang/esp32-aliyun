# esp32-aliyun  

## 1. 阿里云物联网套件简介

![](https://i.imgur.com/OqjGiQL.png)

阿里云物联网套件包括以下部分：  

> - IoT Hub  

>  为设备和物联网应用程序提供发布和接收消息的安全通道。IoT Hub 目前支持 CoAP 协议和 MQTT 协议：
 >  - 设备可以基于 CoAP 协议与 IoT HUb 短连接通信，应用设备低功耗场景。
  - 设备也可以基于 MQTT 协议与 IoT Hub 长连接通信，应用指令实时响应的场景。  
  
>   详情请参考 [IoT Hub](https://help.aliyun.com/document_detail/30548.html?spm=5176.doc30523.2.1.WtHk0t)

> - 安全认证&权限策略
> - 规则引擎
> - 设备影子

ESP32_aliyun_IoT-SDK 移植下载:  

    git clone --recursive https://wang3@gitlab.espressif.cn:6688/cloud/esp32-aliyun.git  
    git submodule update --init --recursive

## 2. framework  

```
.
├── build                                   //存放编译后生成的文件
├── components                              //核心移植组件
│   └── esp32-aliyun                        //esp32-aliyun submodule
│       ├── component.mk                    //makefile 文件
│       ├── IoT-SDK_V2.0                    //阿里物联网套件 IoT-SDK_V2.0
│       ├── platform                        //ESP32 适配平台，HAL 接口实现
│       │   ├── os
│       │   │   ├── esp32                
│       │   │   │   ├── HAL_OS_esp32.c      //OS 相关
│       │   │   │   └── HAL_TCP_esp32.c     //tcp 相关
│       │   │   └── include                 //所有被提供的函数的声明
│       │   │       ├── iot_export.h
│       │   │       └── iot_import.h
│       │   └── ssl
│       │       └── mbedtls                 
│       │           └── HAL_TLS_mbedtls.c
│       └── README.md
├── main                                    //demo main 文件夹     
│   ├── component.mk
│   ├── Kconfig.projbuild                   //menuconfig 用户配置文件
│   └── main.c                              //入口文件
├── Makefile                                //编译入口 makefile
└──  README.md

```
## 3. 硬件平台  

- 开发板：[ESP32-DevKitC 开发板](http://esp-idf.readthedocs.io/en/latest/hw-reference/modules-and-boards.html#esp32-core-board-v2-esp32-devkitc) 或 [ESP-WROVER-KIT 开发板](http://esp-idf.readthedocs.io/en/latest/hw-reference/modules-and-boards.html#esp-wrover-kit)

- 路由器/ Wi-Fi 热点：可以连接外网

## 4. 编译环境搭建( ubuntu 16.04)  

#### 主要是 esp-idf 编译环境搭建

具体请参考 [Get Started](esp-idf.readthedocs.io/en/latest/get-started.html) 

## 5. 配置  

#### IoT-SDK 改动适配  

- 为了提高在 WiFi 连接下传输的稳定性，需要做以下改动：  

    将 `IoT-SDK/src/mqtt/mqtt_client.h` 中 `#define IOTX_MC_REPUB_NUM_MAX                   (20)` 改为 `#define IOTX_MC_REPUB_NUM_MAX                   (100)`
    
    将`IoT-SDK/src/security.h` 中 `#include "tfs/tfs.h"` 改为 `#include "tfs.h"`  

- demo 选择：  
在 `esp32-aliyun` 中有不同的 demo 可以选择编译，默认为 `mqtt-example`;
在 `esp32-aliyun` 中 `main` 文件夹下有不同的 demo，选择对所需的 demo 中 `app_main` 对应的注释即可。

#### ESP32 Wi-Fi 联网配置  

运行 `make menuconfig -> Demo Configuration -> 输入热点的 Wi-Fi SSID & Wi-Fi Password`

#### 阿里云物联网套件控制台中创建设备  
**1) 在制台中创建设备**

 登录[IoT 控制台](http://iot.console.aliyun.com), 创建产品及在产品下创建设备和 Topic 类, 具体步骤如下:

- 创建产品, 可得 `ProductKey`, `ProductSecret` (*华东2站点无`ProductSecret`*)
- 在产品下创建设备, 可得 `DeviceName`, `DeviceSecret`
- 定义 Topic: `$(PRODUCT_KEY)/$(DEVICE_NAME)/data`, 并设置权限为: 设备具有发布与订阅 **(此步骤非常重要)**

> **注意:** 请根据所选站点 (华东 2, 杭州) 创建相应的产品与设备.

具体请参考[控制台使用手册](https://help.aliyun.com/document_detail/42714.html)文档中的`创建产品`, `添加设备`以及`获取设备 Topic`部分.

**2) 填充设备参数**

将`main/main.c`程序文件中的设备参数替换为您在控制台申请到的设备参数.

    // TODO: 在以下段落替换下列宏定义为你在IoT控制台申请到的设备信息
    #define PRODUCT_KEY             "*******************"
    #define DEVICE_NAME             "*******************"
    #define DEVICE_SECRET           "*******************"

## 6. 编译运行

* 返回顶层目录
* 执行 make 指令, 编译 esp32-aliyun_SDK, 命令如下  

		make flash monitor

编译成功后, 开始进行烧写。  
样例程序的基本逻辑流程为:

1. 创建一个MQTT客户端
2. 订阅主题 `$(PRODUCT_KEY)/$(DEVICE_NAME)/data`
3. 循环向该主题发布消息

![](pictures/Selection_014.png)  

运行后打印输出：  

```
wangwangwang@wangwang:~/workspace/esp32-aliyun$ make flash monitor
Flashing binaries to serial port /dev/ttyUSB0 (app at offset 0x10000)...
esptool.py v2.1
Connecting.....
Chip is ESP32D0WDQ6 (revision 0)

...

MONITOR
 
...

I (393) MQTT: Connecting to AP...
I (2623) wifi: n:11 0, o:11 0, ap:255 255, sta:11 0, prof:1
I (2623) wifi: state: init -> auth (b0)
I (2633) wifi: state: auth -> assoc (0)
I (2643) wifi: state: assoc -> run (10)
I (2673) wifi: connected with wwwtest, channel 11
I (3673) event: ip: 192.168.43.156, mask: 255.255.255.0, gw: 192.168.43.1
I (3673) MQTT: Connected.
I (3673) MQTT: MQTT client example begin

...

[inf] _ssl_parse_crt(132): crt content:451
[inf] _ssl_client_init(172):  ok (0 skipped)
[inf] TLSConnectNetwork(337): Connecting to /iot-auth.cn-shanghai.aliyuncs.com/443...
[inf] TLSConnectNetwork(342):  ok
[inf] TLSConnectNetwork(347):   . Setting up the SSL/TLS structure...
[inf] TLSConnectNetwork(357):  ok
[inf] TLSConnectNetwork(392): Performing the SSL/TLS handshake...
[inf] TLSConnectNetwork(400):  ok
[inf] TLSConnectNetwork(404):   . Verifying peer X.509 certificate..
[inf] _real_confirm(81): certificate verification result: 0x00
[dbg] httpclient_send_header(314): REQUEST (Length: 220 Bytes)
> POST /auth/devicename HTTP/1.1
> Host: iot-auth.cn-shanghai.aliyuncs.com
> Accept: text/xml,text/javascript,text/html,application/json
> Content-Length: 193
> Content-Type: application/x-www-form-urlencoded;charset=utf-8
> 
[dbg] httpclient_send_header(319): Written 220 bytes
[dbg] httpclient_send_userdata(336): client_data->post_buf: productKey=9AhUIZuwEiy&deviceName=esp32_01&signmethod=hmacsha1&sign=315d81092e310ea6e88aaaf6407351e5190ec956&version=default&clientId=9AhUIZuwEiy.esp32_01&timestamp=2524608000000&resources=mqtt
[dbg] httpclient_send_userdata(341): Written 193 bytes
[inf] httpclient_recv(381): 255 bytes has been read
[dbg] httpclient_recv_response(755): RESPONSE (Length: 255 Bytes)
< HTTP/1.1 200 OK
< Date: Fri, 22 Sep 2017 06:46:58 GMT
< Content-Type: application/json;charset=UTF-8
< Content-Length: 216
< Connection: keep-alive
< Server: Tengine
< Strict-Transport-Security: max-age=0
< Timing-Allow-Origin: *
< 

...

[inf] iotx_mc_init(1948): MQTT init success!
[inf] _ssl_client_init(164): Loading the CA root certificate ...
cert. version     : 3
serial number     : 04:00:00:00:00:01:15:4B:5A:C3:94
issuer name       : C=BE, O=GlobalSign nv-sa, OU=Root CA, CN=GlobalSign Root CA
subject name      : C=BE, O=GlobalSign nv-sa, OU=Root CA, CN=GlobalSign Root CA
issued  on        : 1998-09-01 12:00:00
expires on        : 2028-01-28 12:00:00
signed using      : RSA with SHA1
RSA key size      : 2048 bits
basic constraints : CA=true
key usage         : Key Cert Sign, CRL Sign
[inf] _ssl_parse_crt(132): crt content:451
[inf] _ssl_client_init(172):  ok (0 skipped)
[inf] TLSConnectNetwork(337): Connecting to /public.iot-as-mqtt.cn-shanghai.aliyuncs.com/1883...
[inf] TLSConnectNetwork(342):  ok
[inf] TLSConnectNetwork(347):   . Setting up the SSL/TLS structure...
[inf] TLSConnectNetwork(357):  ok
[inf] TLSConnectNetwork(392): Performing the SSL/TLS handshake...
[inf] TLSConnectNetwork(400):  ok
[inf] TLSConnectNetwork(404):   . Verifying peer X.509 certificate..
[inf] _real_confirm(81): certificate verification result: 0x00
[dbg] iotx_mc_connect(2263): start MQTT connection with parameters: clientid=9AhUIZuwEiy.esp32_01|securemode=-1,timestamp=2524608000000,signmethod=hmacsha1,gw=0|, username=wiunMmUYWebSJgayWwQx0010bad000, password=b94fdc7929a744ffa1145a18517424e1
[inf] iotx_mc_connect(2283): mqtt connect success!
```




