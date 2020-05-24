#!/bin/bash

dest="/tmp"

aws s3 cp  s3://resource-virtual-office/win-packages/GoogleChromeStandaloneEnterprise64.msi $dest
aws s3 cp  s3://resource-virtual-office/win-packages/windowsserver2019-jplangpack.iso $dest
