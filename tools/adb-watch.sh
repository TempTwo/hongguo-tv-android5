#!/bin/bash
IP="192.168.0.x"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APK="$SCRIPT_DIR/../apk/hongguo-tv-android5-arm32.apk"
LOG="$SCRIPT_DIR/adb-watch.log"
PORTS="xxxx"
PKG="rocks.aston.hongguotv.android5test"
ACT="rocks.aston.hongguotv.MainActivity"

log() { echo "[$(date '+%F %T')] $*" >> "$LOG"; }

log "=== watcher started ==="
for i in $(seq 1 240); do
  FOUND=""
  for p in $PORTS; do
    if nc -z -G 3 "$IP" "$p" 2>/dev/null; then FOUND="$p"; break; fi
  done
  if [ -n "$FOUND" ]; then
    log "port $FOUND OPEN, adb connect..."
    SER="$IP:$FOUND"
    adb connect "$SER" >> "$LOG" 2>&1
    sleep 3
    STATE=$(adb devices | awk -v s="$SER" '$0 ~ ("^"s) {print $2}')
    log "adb state: '${STATE:-none}'"
    if [ "$STATE" = "device" ]; then
      log "AUTHORIZED. fetching device info..."
      adb -s "$SER" shell getprop ro.product.model >> "$LOG" 2>&1
      adb -s "$SER" shell getprop ro.product.manufacturer >> "$LOG" 2>&1
      adb -s "$SER" shell getprop ro.build.version.release >> "$LOG" 2>&1
      adb -s "$SER" shell getprop ro.build.version.sdk >> "$LOG" 2>&1
      adb -s "$SER" shell getprop ro.product.cpu.abilist >> "$LOG" 2>&1
      log "installing APK ($APK)..."
      adb -s "$SER" install -r "$APK" >> "$LOG" 2>&1
      log "install exit=$?"
      log "launching $PKG/$ACT ..."
      adb -s "$SER" shell am start -n "$PKG/$ACT" >> "$LOG" 2>&1
      log "=== DONE (connected on port $FOUND) ==="
      exit 0
    elif [ "$STATE" = "unauthorized" ]; then
      log "unauthorized — 请在电视上勾选『始终允许』并点确定"
    else
      log "state not device, retry later"
    fi
  fi
  sleep 15
done
log "=== watcher timed out (TV adb port never opened) ==="
