# TxAdSupportKit

[![CI Status](https://img.shields.io/travis/bogonchar/TxAdSupportKit.svg?style=flat)](https://travis-ci.org/bogonchar/TxAdSupportKit)
[![Version](https://img.shields.io/cocoapods/v/TxAdSupportKit.svg?style=flat)](https://cocoapods.org/pods/TxAdSupportKit)
[![License](https://img.shields.io/cocoapods/l/TxAdSupportKit.svg?style=flat)](https://cocoapods.org/pods/TxAdSupportKit)
[![Platform](https://img.shields.io/cocoapods/p/TxAdSupportKit.svg?style=flat)](https://cocoapods.org/pods/TxAdSupportKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TxAdSupportKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TxAdSupportKit'
```

## Author

bogonchar, zhangqixcu@gmail.com

#!/bin/bash
set -e

# === 配置 ===
BRANCHES=("main" "4.15.6")  # 需要清理和强推的分支
LFS_PATTERNS=("*.xcframework" "*.framework")  # 用 LFS 管理的文件类型

echo "🚀 Step 1: 安装 git-lfs 并初始化"
brew install git-lfs || true
git lfs install

echo "🚀 Step 2: 设置 Git LFS 跟踪"
for pattern in "${LFS_PATTERNS[@]}"; do
    git lfs track "$pattern"
done

git add .gitattributes
git commit -m "chore: enable git-lfs tracking" || true

echo "🚀 Step 3: 使用 git-filter-repo 清理历史中的大文件 (>100M)"
brew install git-filter-repo || true
git filter-repo --strip-blobs-bigger-than 100M

echo "🚀 Step 4: 重新添加大文件到 Git LFS"
for pattern in "${LFS_PATTERNS[@]}"; do
    git add $pattern || true
done
git commit -m "chore: re-add large files with Git LFS" || true

echo "🚀 Step 5: 强制推送到远程分支"
for branch in "${BRANCHES[@]}"; do
    echo "   👉 推送 $branch ..."
    git push origin "$branch" --force
done

echo "✅ 完成！仓库已清理并迁移到 Git LFS。"
echo "⚠️ 注意：团队成员需要重新 clone 仓库。"


## License

# 1. 在本地重新 clone 一个空仓库
git clone --no-checkout <your-repo-url> new-repo
cd new-repo

# 2. 初始化 LFS
git lfs install

# 3. 添加 LFS 跟踪规则
git lfs track "*.xcframework"
git lfs track "BUAdSDK"

# 4. 添加文件
git add .
git commit -m "Initial commit with LFS"

# 5. Push
git push origin main


TxAdSupportKit is available under the MIT license. See the LICENSE file for more info.

pod lib create TxAdSupportKit  

pod lib lint TxAdSupportKit.podspec --allow-warnings

git add .
git commit -m "release 4.15.10"


git push origin main

git tag 4.15.10
git push origin --tags

pod trunk push TxAdSupportKit.podspec --allow-warnings

pod repo update --verbose
