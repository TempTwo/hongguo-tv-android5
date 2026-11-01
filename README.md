# 红果短剧 TV · Android 5 正式版（armv7a）

> 本仓库是 [aston314/hongguo-tv-releases](https://github.com/aston314/hongguo-tv-releases) 的
> **Android 5 二次修改版**，原作者为 **aston314**，应用版权与全部权利归原作者所有。
>
> 上游仓库为**纯发布仓库**（只放 APK 与更新清单，源码在作者私有仓库），因此本仓库**不包含、也无法提供源码**。
> 这里基于上游已发布的 **Android 5（API 21）** 测试包做二次打包：去掉「测试」标识并重新签名，作为 Android 5 设备的正式安装包。

---

## 这是什么

[红果短剧](https://github.com/aston314/hongguo-tv-releases) 是面向 Android TV 的短剧播放应用。
正式版最低要求 **Android 6 / API 23**，在 Android 5.0 / 5.1 的老设备上无法安装。

上游在 `android5-compat-0.2.136-test.1` 预发布中提供了从源码**面向 API 21 重建**的包（不是改 Manifest 后重签）。
本仓库把它二次打包成正式形态，方便 Android 5 的 32 位 ARM 设备直接下载安装。

## 下载

Releases 页提供可直接安装的 APK：

| 文件 | 说明 |
| --- | --- |
| `hongguo-tv-android5-arm32.apk` | **armv7a（32 位 ARM）专用**，minSdk 21 |
| `hongguo-tv-android5.apk` | 通用包（arm64-v8a / armeabi-v7a / x86_64） |

- 包名 `rocks.aston.hongguotv.android5`，版本 `0.2.136-android5`（versionCode 1）
- `minSdk 21`（Android 5.0+） / `targetSdk 35`
- 应用显示名 **「红果短剧」**，与官方包 `rocks.aston.hongguotv` 可共存

## 相对上游改了什么

| 项 | 上游 `android5-compat-0.2.136-test.1` | 本仓库 |
| --- | --- | --- |
| 包名 | `rocks.aston.hongguotv.android5test` | `rocks.aston.hongguotv.android5` |
| 应用名 | 红果短剧 · Android 5 测试 | **红果短剧** |
| 版本名 | `0.2.136-android5-test.1` | `0.2.136-android5` |
| 签名 | 上游作者签名 | 独立签名（专用 release keystore） |

- 仅改动清单/字符串（包名、应用名、版本名），**未改动任何代码、原生库或资源内容**。
- 原生 Go 内核 `libhongguotv.so` 保持不变；其内部版本号日志仍显示上游构建标识，不影响功能与界面。
- 因包名与签名均不同，**不能**直接覆盖上游测试版，需先卸载旧包再安装本包。

## 与上游的关系

- 上游仓库：<https://github.com/aston314/hongguo-tv-releases>（作者 aston314）
- 源码在上游私有仓库，本仓库不含源码；后续请以官方上游为准，问题反馈优先提交到
  上游 [Issues](https://github.com/aston314/hongguo-tv-releases/issues)。
- 校验值见 [SHA256SUMS.txt](SHA256SUMS.txt)。

## 实机验证

| 项 | 值 |
| --- | --- |
| 电视 | 创维 Skyworth 8H52 G3（HiSilicon Hi3751V551） |
| 系统 | Android 5.1.1（API 22） |
| ABI | `armeabi-v7a, armeabi`（32 位） |
| 安装 | `adb install` Success |
| 冷启动 | 正常，MainActivity 前台显示（Displayed +615ms） |
| 原生内核 | Go core 正常监听并返回 UI（HTTP 200） |
| WebView | Chromium 39 正常渲染，无 crash / ANR |

> 通用包（arm64-v8a / x86_64）与本仓库 armv7a 包同源同改法，但**仅 armv7a 在真机验证过**。

## 安装

1. 在 Releases 下载 `hongguo-tv-android5-arm32.apk`；
2. `adb install -r hongguo-tv-android5-arm32.apk`（或 U 盘侧载）；
3. 启动「红果短剧」。

若电脑无法直连电视（路由器无线客户端隔离导致 `adb connect` 报 `No route to host`），
可经路由器 SSH 反向代理：`ssh -N -L 5555:192.168.0.9:5555 router`，再 `adb connect 127.0.0.1:5555`。

## 致谢与版权

- 应用版权归原作者 [aston314](https://github.com/aston314) 所有，本仓库不主张任何权利。
- MPV 相关库为 LGPL，许可声明见应用内「设置 → 开源许可」及上游私有源码 Release。
- 本仓库仅做二次打包（去测试标识、重签名）与实机记录，不对应用功能做任何改动。
