//
//  AppDelegate.m
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "YYUMSocialManager.h"
#import <TwitterKit/TWTRKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [self registerUMSDK];
    return YES;
}

- (void)registerUMSDK {
    
    /* 设置Facebook的appKey和UrlString */
    [UMConfigure initWithAppkey:@"5bce94e9b465f57cbe00027e" channel:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook
                                          appKey:@"3f25f76324a795e12c01ee966b3d5fde"
                                       appSecret:@"" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Instagram appKey:@"1e24ee7c48101897d55808c05f860247" appSecret:@"" redirectURL:@"http://mobile.umeng.com/social"];
    
    [[Twitter sharedInstance] startWithConsumerKey:@"gAJCfCx18lY3SdXnT9vsOT7Sb" consumerSecret:@"v64tQkknq5hDS9gWOwTukyYDzpZD32Ik8Au5VF7dr4oaiJpinM"];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        [[FBSDKApplicationDelegate sharedInstance] application:application
                                                       openURL:url
                                             sourceApplication:sourceApplication
                                                    annotation:annotation
         ];
    }
    return result;
}



@end
