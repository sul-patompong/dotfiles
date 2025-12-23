#!/bin/bash

# Configure TLP based on hardware type (ThinkPad vs Desktop)

TLP_CONFIG_DIR="/etc/tlp.d"
product_version=$(cat /sys/class/dmi/id/product_version 2>/dev/null)

# Check if ThinkPad
if echo "$product_version" | grep -qi "thinkpad"; then
  is_thinkpad=true
  TLP_CONFIG_FILE="$TLP_CONFIG_DIR/01-thinkpad.conf"
  echo "ThinkPad detected: $product_version"
else
  is_thinkpad=false
  TLP_CONFIG_FILE="$TLP_CONFIG_DIR/01-desktop.conf"
  echo "Desktop PC detected"
fi

# Create TLP config directory if it doesn't exist
if [ ! -d "$TLP_CONFIG_DIR" ]; then
  echo "Creating TLP config directory..."
  sudo mkdir -p "$TLP_CONFIG_DIR"
fi

# Create hardware-specific TLP configuration
if [ "$is_thinkpad" = true ]; then
  echo "Creating TLP configuration for ThinkPad..."
  sudo tee "$TLP_CONFIG_FILE" > /dev/null <<'EOF'
# TLP configuration for ThinkPad
# This file contains ThinkPad-specific optimizations

# CPU Energy/Performance Policy (HWP)
# performance, balance_performance, default, balance_power, power
CPU_ENERGY_PERF_POLICY_ON_AC=balance_performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power

# CPU Boost
# 0 = disable, 1 = enable
CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0

# Platform Profile (requires kernel 5.18+)
# performance, balanced, low-power
PLATFORM_PROFILE_ON_AC=balanced
PLATFORM_PROFILE_ON_BAT=low-power

# Battery Charge Thresholds (ThinkPad only)
# Stop charging when battery reaches this percentage
# Start charging when battery drops below this percentage
# This extends battery lifespan significantly
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80

# Processor Intel P-State Performance
# 0..100 (%)
CPU_MIN_PERF_ON_AC=0
CPU_MAX_PERF_ON_AC=100
CPU_MIN_PERF_ON_BAT=0
CPU_MAX_PERF_ON_BAT=50

# WiFi Power Saving
# on = enable, off = disable
WIFI_PWR_ON_AC=off
WIFI_PWR_ON_BAT=on

# PCIe Active State Power Management (ASPM)
# default, performance, powersave, powersupersave
PCIE_ASPM_ON_AC=performance
PCIE_ASPM_ON_BAT=powersupersave

# Runtime Power Management for PCI(e) devices
# on = enable, auto = enable with timeout, off = disable
RUNTIME_PM_ON_AC=on
RUNTIME_PM_ON_BAT=auto

# USB Autosuspend
USB_AUTOSUSPEND=1

# Disk devices (SATA/NVMe)
# 0 = disable, 1-255 = Advanced Power Management level
# 254 = lowest power consumption
DISK_APM_LEVEL_ON_AC="254 254"
DISK_APM_LEVEL_ON_BAT="128 128"

# SATA Link Power Management (ALPM)
# min_power, med_power_with_dipm, medium_power, max_performance
SATA_LINKPWR_ON_AC=max_performance
SATA_LINKPWR_ON_BAT=min_power

# NVMe Power Management
# Set to aggressive power saving on battery
AHCI_RUNTIME_PM_ON_AC=auto
AHCI_RUNTIME_PM_ON_BAT=auto
EOF

echo "ThinkPad TLP configuration created successfully."
  echo ""
  echo "Battery charge thresholds set to:"
  echo "  - Start charging at: 75%"
  echo "  - Stop charging at: 80%"
  echo "This will help extend your battery lifespan."

else
  # Desktop configuration - minimal, performance-oriented
  echo "Creating TLP configuration for desktop..."
  sudo tee "$TLP_CONFIG_FILE" > /dev/null <<'EOF'
# TLP configuration for Desktop PC
# Performance-focused configuration

# CPU Energy/Performance Policy - maximum performance
CPU_ENERGY_PERF_POLICY_ON_AC=performance

# CPU Boost - always enabled on desktop
CPU_BOOST_ON_AC=1

# Platform Profile - always performance on desktop
PLATFORM_PROFILE_ON_AC=performance

# Processor Performance - allow full performance
CPU_MIN_PERF_ON_AC=0
CPU_MAX_PERF_ON_AC=100

# WiFi Power Saving - disabled for better network performance
WIFI_PWR_ON_AC=off

# PCIe ASPM - performance mode
PCIE_ASPM_ON_AC=performance

# Runtime Power Management - minimal on desktop
RUNTIME_PM_ON_AC=on

# USB Autosuspend - enabled for peripherals not in use
USB_AUTOSUSPEND=1

# Disk APM - balanced (not too aggressive)
DISK_APM_LEVEL_ON_AC="254 254"

# SATA Link Power Management - max performance
SATA_LINKPWR_ON_AC=max_performance

# NVMe/AHCI Runtime PM
AHCI_RUNTIME_PM_ON_AC=auto
EOF

  echo "Desktop TLP configuration created successfully."
  echo "Settings optimized for performance with minimal power saving."
fi
