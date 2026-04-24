#!/bin/bash

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

# Check for active Ethernet / USB LAN
ETHERNET=false
for iface in $(networksetup -listallhardwareports | awk '/Hardware Port:.*(Ethernet|LAN)/{getline; print $2}'); do
  if ifconfig "$iface" 2>/dev/null | grep -q "status: active"; then
    ETHERNET=true
    break
  fi
done

if [ "$ETHERNET" = true ]; then
  ICON="󰈀"
else
  RSSI=$("$WIFI_RSSI_BIN" 2>/dev/null)
  CONNECTED=$(ipconfig getsummary en0 2>/dev/null | grep -c "SSID")

  if [ "$CONNECTED" -eq 0 ]; then
    ICON="󰤭"
  elif [ "${RSSI:-0}" -ge -50 ]; then
    ICON="󰤨"
  elif [ "$RSSI" -ge -60 ]; then
    ICON="󰤥"
  elif [ "$RSSI" -ge -70 ]; then
    ICON="󰤢"
  else
    ICON="󰤟"
  fi
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  label.drawing=off
