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
- (void)showUpdateWithForce;

//更新提示
- (void)showUpdateWithConfirmation;

@end
