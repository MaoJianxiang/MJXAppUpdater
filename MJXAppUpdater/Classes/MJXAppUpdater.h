//
//  MJXAppUpdater.h
//  AppUpdaterTest
//
//  Created by Mao on 2017/2/26.
//  Copyright © 2017年 Mao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <SystemConfiguration/SystemConfiguration.h>


@interface MJXAppUpdater : NSObject <UIAlertViewDelegate>
//提示框的标题
@property (nonatomic, weak) NSString *alertTitle;
//提示的内容显示
@property (nonatomic, weak) NSString *alertMessage;
//升级按钮的标题
@property (nonatomic, weak) NSString *updateButtonTitle;
//取消按钮的标题
@property (nonatomic, weak) NSString *cancelButtonTitle;

//单例模式
+ (id)sharedUpdater;

//强制更新
//available:即打开AppStore失败后,App是否也能暂时继续使用。
//若传NO,即打开AppStore失败后会退出程序，传nil和YES时，默认也可以暂时网络不好时使用。
- (void)showUpdateWithForceAllowNetworkFailure:(BOOL)available;

//更新提示
- (void)showUpdateWithConfirmation;

@end
