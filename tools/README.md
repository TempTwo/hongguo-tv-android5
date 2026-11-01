# 连接与安装工具

电脑直连电视 `adb connect 192.168.0.9` 可能失败（报 `No route to host`），
常见原因是路由器开启了**无线客户端隔离**，或电视处于深度休眠、Wi-Fi 不响应来自其他客户端的 ARP。

此时可借助**路由器作为 SSH 跳板做反向代理**，把电视的 adb 端口（5555）经路由器转发到本机：

```bash
# 1. 经路由器 SSH 建立本地隧道：本机 5555 -> 路由器 -> 电视 192.168.0.9:5555
ssh -N -o ServerAliveInterval=30 -o ServerAliveCountMax=3 \
    -L 5555:192.168.0.9:5555 router

# 2. 另开一个终端，连接本机隧道端口
adb connect 127.0.0.1:5555

# 3. 安装
adb -s 127.0.0.1:5555 install -r hongguo-tv-android5-arm32.apk

# 4. 启动
adb -s 127.0.0.1:5555 shell am start -n rocks.aston.hongguotv.android5test/rocks.aston.hongguotv.MainActivity
```

`router` 是 `~/.ssh/config` 中的别名（对应 192.168.0.1 的路由器，这里实测为 ImmortalWrt/OpenWrt）。
请按你的环境改成实际路由器地址与登录方式。

## adb-watch.sh

`adb-watch.sh` 是一个自动检测脚本：轮询本地隧道端口，一旦电视 adb 上线就自动
`adb connect`、拉取设备信息、`install` 并启动应用，全程日志写入 `adb-watch.log`。

```bash
./adb-watch.sh
```

注意：脚本内的 APK 路径、包名、Activity 为当前仓库默认值，按需修改。
