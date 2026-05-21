#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

WIFI_RSSI_BIN="$HOME/.local/bin/wifi-rssi"

# Build RSSI helper once (CoreWLAN needs a compiled binary)
if [ ! -x "$WIFI_RSSI_BIN" ]; then
  mkdir -p "$HOME/.local/bin"
  cat > /tmp/wifi_rssi.swift << 'SWIFT'
import CoreWLAN
if let iface = CWWiFiClient.shared().interface() {
    print(iface.rssiValue())
} else {
    print("0")
}
SWIFT
  swiftc /tmp/wifi_rssi.swift -o "$WIFI_RSSI_BIN" -framework CoreWLAN 2>/dev/null
  rm -f /tmp/wifi_rssi.swift
fi

# Detect active Ethernet / USB LAN
ETHERNET=false
ETH_IFACE=""
for iface in $(networksetup -listallhardwareports | awk '/Hardware Port:.*(Ethernet|LAN)/{getline; print $2}'); do
  if ifconfig "$iface" 2>/dev/null | grep -q "status: active"; then
    ETHERNET=true
    ETH_IFACE="$iface"
    break
  fi
done

SSID=""
IP=""
ROUTER=""
RSSI=""

if [ "$ETHERNET" = true ]; then
  ICON="$ICON_ETHERNET"
  SSID="Ethernet ($ETH_IFACE)"
  IP=$(ipconfig getifaddr "$ETH_IFACE" 2>/dev/null)
  ROUTER=$(netstat -rn -f inet 2>/dev/null | awk '/^default/{print $2; exit}')
  RSSI="—"
else
  RSSI_VAL=$("$WIFI_RSSI_BIN" 2>/dev/null)
  CONNECTED=$(ipconfig getsummary en0 2>/dev/null | grep -c "SSID")

  if [ "$CONNECTED" -eq 0 ]; then
    ICON="$ICON_WIFI_OFF"
    SSID="Disconnected"
  elif [ "${RSSI_VAL:-0}" -ge -50 ]; then
    ICON="$ICON_WIFI_4"
  elif [ "$RSSI_VAL" -ge -60 ]; then
    ICON="$ICON_WIFI_3"
  elif [ "$RSSI_VAL" -ge -70 ]; then
    ICON="$ICON_WIFI_2"
  else
    ICON="$ICON_WIFI_1"
  fi

  if [ "$CONNECTED" -gt 0 ]; then
    SSID=$(ipconfig getsummary en0 2>/dev/null | awk -F' SSID : ' '/ SSID : / {print $2; exit}')
    [ -z "$SSID" ] && SSID="Connected"
    IP=$(ipconfig getifaddr en0 2>/dev/null)
    ROUTER=$(netstat -rn -f inet 2>/dev/null | awk '/^default/{print $2; exit}')
    RSSI="${RSSI_VAL} dBm"
  fi
fi

[ -z "$IP" ]     && IP="—"
[ -z "$ROUTER" ] && ROUTER="—"

sketchybar --set "$NAME" icon="$ICON" label.drawing=off
sketchybar --set wifi.popup.ssid   label="SSID:   $SSID" \
           --set wifi.popup.ip     label="IP:     $IP" \
           --set wifi.popup.router label="Router: $ROUTER" \
           --set wifi.popup.rssi   label="RSSI:   $RSSI"
