# MJXAppUpdater

[![CI Status](http://img.shields.io/travis/15208105440@163.com/MJXAppUpdater.svg?style=flat)](https://travis-ci.org/15208105440@163.com/MJXAppUpdater)
[![Version](https://img.shields.io/cocoapods/v/MJXAppUpdater.svg?style=flat)](http://cocoapods.org/pods/MJXAppUpdater)
[![License](https://img.shields.io/cocoapods/l/MJXAppUpdater.svg?style=flat)](http://cocoapods.org/pods/MJXAppUpdater)
[![Platform](https://img.shields.io/cocoapods/p/MJXAppUpdater.svg?style=flat)](http://cocoapods.org/pods/MJXAppUpdater)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
## 1.2特性

1. 提示用户有新版本，可以更新了。
2. 强制用户有新版本后必须更新使用。
3. 修复当强制用户更新新版本后，在网络不好的情况下，打开AppStore失败后是否可以暂时使用当前版本的App。


## 原理

通过获取AppStore上的版本号，跟当前运行的版本号进行比对，若AppStore上存在新版本，就提示用户打开AppStore进行更新。

## 使用

#### 1. 用Cocoapods可以导入框架 pod 'MJXAppUpdater', '~> 1.2'  或者直接把下载的MJXAppUpdater.h和MJXAppUpdater.m文件接到工程中。
     
#### 2. 在AppDelegate中，导入头文件  #import "MJXAppUpdater.h"

#### 3. 提示用户
  
 一般提示：[[MJXAppUpdater sharedUpdater] showUpdateWithConfirmation];

 若是强制更新则用：

参数available:即打开AppStore失败后,App是否也能暂时继续使用。
若传NO,即打开AppStore失败后会退出程序，传nil和YES时，默认也可以暂时网络不好时使用。

 [[MJXAppUpdater sharedUpdater] showUpdateWithForceAllowNetworkFailure:nil];





```ruby
pod "MJXAppUpdater"
```

## Author

毛建祥, 15208105440@163.com

## License

MJXAppUpdater is available under the MIT license. See the LICENSE file for more info.
