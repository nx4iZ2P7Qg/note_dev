#!/usr/bin/env bash

# 查看bit rot情况，corruption_errs
btrfs device stats /dev/sde1
# 完整性检查
