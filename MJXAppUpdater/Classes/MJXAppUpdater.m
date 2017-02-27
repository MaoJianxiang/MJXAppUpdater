//
//  MJXAppUpdater.m
//  AppUpdaterTest
//
//  Created by Mao on 2017/2/26.
//  Copyright © 2017年 Mao. All rights reserved.
//

#import "MJXAppUpdater.h"

@implementation MJXAppUpdater

#pragma mark - 初始化
+(id)sharedUpdater{
    static MJXAppUpdater *sharedAppUpdater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppUpdater = [[MJXAppUpdater alloc]init];
    });
    return sharedAppUpdater;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.alertTitle = @"新版本";
        self.alertMessage = @"版本 %@ 是可用的";
        self.updateButtonTitle = @"更新";
        self.cancelButtonTitle = @"取消";
    }
    return self;
}

#pragma mark - 强制更新

- (void)showUpdateWithForce{
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersion:^(BOOL newVersion, NSString *version) {
        if (newVersion) {
            [[self alertUpdateForVersion:version withForce:YES] show];
        }
    }];
}

#pragma mark - 更新
- (void)showUpdateWithConfirmation{
    
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersion:^(BOOL newVersion, NSString *version) {
        if (newVersion) {
            [[self alertUpdateForVersion:version withForce:NO] show];
        }
    }];
}


#pragma mark - 私有方法
- (BOOL)hasConnection
{
    const char *host = "itunes.apple.com";
    BOOL reachable;
    BOOL success;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    reachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return reachable;
}

NSString *appStoreURL = nil;

- (void)checkNewAppVersion:(void(^)(BOOL newVersion, NSString *version))completion
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = bundleInfo[@"CFBundleIdentifier"];
    NSString *currentVersion = bundleInfo[@"CFBundleShortVersionString"];
    NSURL *lookupURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?bundleId=%@", bundleIdentifier]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        
        NSData *lookupResults = [NSData dataWithContentsOfURL:lookupURL];
        if (!lookupResults) {
            completion(NO, nil);
            return;
        }
        NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:lookupResults options:NSJSONReadingMutableLeaves error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSUInteger resultCount = [jsonResults[@"resultCount"] integerValue];
            if (resultCount){
                NSDictionary *appDetails = [jsonResults[@"results"] firstObject];
                NSString *appItunesUrl = [appDetails[@"trackViewUrl"] stringByReplacingOccurrencesOfString:@"&uo=4" withString:@""];
                NSString *latestVersion = appDetails[@"version"];
                if ([latestVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                    appStoreURL = appItunesUrl;
                    completion(YES, latestVersion);
                } else {
                    completion(NO, nil);
                }
            } else {
                completion(NO, nil);
            }
        });
    });
}

- (UIAlertView *)alertUpdateForVersion:(NSString *)version withForce:(BOOL)force
{
    NSString *msg = [NSString stringWithFormat:self.alertMessage, version];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.alertTitle message:msg delegate:self cancelButtonTitle:force ? nil:self.updateButtonTitle otherButtonTitles:force ? self.updateButtonTitle:self.cancelButtonTitle, nil];
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSURL *appUrl = [NSURL URLWithString:appStoreURL];
        if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
            [[UIApplication sharedApplication] openURL:appUrl];
        } else {
            UIAlertView *cantOpenUrlAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能打开应用商店,请稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [cantOpenUrlAlert show];
        }
    }
}
@end
