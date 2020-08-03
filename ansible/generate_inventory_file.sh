#!/bin/bash

win_ips=`aws ec2 describe-instances --filters "Name=tag:Name,Values=Windows_Server" | jq -r '.Reservations[].Instances[].PrivateIpAddress'`

inventory_file="inventory/win-servers.yml"

echo "[win_2019]" > $inventory_file
echo "${win_ips}" >> $inventory_file

