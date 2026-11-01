# 红果短剧 TV · Android 5 适配版（armv7a）

> 本仓库是 [aston314/hongguo-tv-releases](https://github.com/aston314/hongguo-tv-releases) 的
> **Android 5 适配镜像**，原作者为 **aston314**，应用版权与全部权利归原作者所有。
>
> 上游仓库为**纯发布仓库**（只放 APK 与更新清单，源码在作者私有仓库），因此本仓库**不包含、也无法提供源码**。
> 这里仅镜像上游已发布的 **Android 5（API 21）/ armeabi-v7a** 测试包，并补充实机验证记录与安装说明。

---

## 这是什么

[红果短剧](https://github.com/aston314/hongguo-tv-releases) 是面向 Android TV 的短剧播放应用。
正式版最低要求 **Android 6 / API 23**，在 Android 5.0 / 5.1 的老设备上无法安装。

上游在 `android5-compat-0.2.136-test.1` 预发布中提供了从源码**面向 API 21 重建**的测试包
（不是改 Manifest 后重签）。本仓库把其中的 **armeabi-v7a（armv7a）** 版本镜像过来，
方便 Android 5 的 32 位 ARM 设备直接下载安装。

## 下载

Releases 页提供可直接安装的 APK：

| 文件 | 说明 |
| --- | --- |
| `hongguo-tv-android5-test.1-arm32.apk` | **armv7a（32 位 ARM）专用**，minSdk 21 |
| `hongguo-tv-android5-test.1.apk` | 通用包（arm64-v8a / armeabi-v7a / x86_64） |

- 包名 `rocks.aston.hongguotv.android5test`，版本 `0.2.136-android5-test.1`
- `minSdk 21`（Android 5.0+） / `targetSdk 35`，签名与上游一致
- 应用名称「红果短剧 · Android 5 测试」，可与正式版共存

## 与上游的关系

- 上游仓库：<https://github.com/aston314/hongguo-tv-releases>（作者 aston314）
- 本仓库的 APK **未做任何修改**，SHA256 与上游 `android5-compat-0.2.136-test.1` 发布完全一致，
  见 [SHA256SUMS.txt](SHA256SUMS.txt)。
- 源码在上游私有仓库，本仓库不含源码；后续请以官方上游为准，问题反馈优先提交到
  上游 [Issues](https://github.com/aston314/hongguo-tv-releases/issues)。

## 实机验证

| 项 | 值 |
| --- | --- |
| 电视 | 创维 Skyworth 8H52 G3（HiSilicon Hi3751V551） |
| 系统 | Android 5.1.1（API 22） |
| ABI | `armeabi-v7a, armeabi`（32 位） |
| 安装 | `adb install` Success |
| 冷启动 | 正常，MainActivity 前台显示（Displayed +739ms） |
| 原生内核 | Go core 正常监听并返回 UI（HTTP 200） |
| WebView | Chromium 39 正常渲染，无 crash / ANR |

## 安装

1. 在 Releases 下载 `hongguo-tv-android5-test.1-arm32.apk`；
2. `adb install -r hongguo-tv-android5-test.1-arm32.apk`（或 U 盘侧载）；
3. 启动「红果短剧 · Android 5 测试」。

如果电脑无法直连电视（例如路由器开启了无线客户端隔离、`adb connect 192.168.0.9` 报
`No route to host`），可以经路由器 SSH 反向代理连接，见 [tools/README.md](tools/README.md)。

## 致谢与版权

- 应用版权归原作者 [aston314](https://github.com/aston314) 所有，本仓库不主张任何权利。
- MPV 相关库为 LGPL，许可声明见应用内「设置 → 开源许可」及上游私有源码 Release。
- 本仓库仅做镜像与实机记录，不对应用做任何二次修改。
