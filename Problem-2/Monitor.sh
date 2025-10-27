#!/bin/bash

# ==========================================================
#  System & Application Health Monitoring Script (Ubuntu)
# ==========================================================

# Log file location
LOGFILE="/home/ubuntu/system_health.log"

# Threshold values
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90

# Application URL (replace with your app or website)
APP_URL="http://example.com"

# -------------------------------
# Get System Health Information
# -------------------------------

# CPU Usage (using top)
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')

# Memory Usage
MEM=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

# Disk Usage (Root partition)
DISK=$(df / | grep / | awk '{print int($5)}')

# Running Processes
PROCESSES=$(ps aux | wc -l)

# -------------------------------
# Log Data to File
# -------------------------------

echo "----------------------------------------" >> $LOGFILE
echo "$(date '+%Y-%m-%d %H:%M:%S')" >> $LOGFILE
echo "CPU Usage: ${CPU}%" >> $LOGFILE
echo "Memory Usage: ${MEM}%" >> $LOGFILE
echo "Disk Usage: ${DISK}%" >> $LOGFILE
echo "Running Processes: ${PROCESSES}" >> $LOGFILE

# -------------------------------
# Check Thresholds
# -------------------------------

if [ $CPU -gt $CPU_THRESHOLD ]; then
  echo "⚠️ WARNING: High CPU usage detected (${CPU}%)" >> $LOGFILE
fi

if [ $MEM -gt $MEM_THRESHOLD ]; then
  echo "⚠️ WARNING: High Memory usage detected (${MEM}%)" >> $LOGFILE
fi

if [ $DISK -gt $DISK_THRESHOLD ]; then
  echo "⚠️ WARNING: High Disk usage detected (${DISK}%)" >> $LOGFILE
fi

# -------------------------------
# Application Health Check
# -------------------------------

STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" $APP_URL)

if [ "$STATUS_CODE" -eq 200 ]; then
  echo "✅ Application is UP (HTTP $STATUS_CODE)" >> $LOGFILE
else
  echo "❌ Application is DOWN (HTTP $STATUS_CODE)" >> $LOGFILE
fi

# -------------------------------
# Show Last Few Log Entries
# -------------------------------

echo "Latest Status:"
tail -n 8 $LOGFILE
