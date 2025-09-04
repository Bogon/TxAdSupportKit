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

## License

TxAdSupportKit is available under the MIT license. See the LICENSE file for more info.

pod lib create TxAdSupportKit  

pod lib lint TxAdSupportKit.podspec --allow-warnings

git add .
git commit -m "release 4.15.7"
git tag 4.15.8

git push origin main --tags

pod trunk push TxAdSupportKit.podspec --allow-warnings

pod repo update --verbose
