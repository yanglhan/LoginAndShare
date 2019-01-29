//
//  YYUMSocialManager.m
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYUMSocialManager.h"
#import <TwitterKit/TWTRKit.h>

@implementation YYUMSocialManager

+ (void)setUmSocialAppkey:(NSString *)umSocialAppkey openLog:(BOOL)isLog{
    [[UMSocialManager defaultManager] openLog:isLog];
}

#pragma mark - login

+ (void)loginWith:(UMSocialPlatformType)platform
completionHandler:(YYLoginBlock)handler {
    NSInteger type = platform;
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:[self getCurrentVC] completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        YYAccountModel *model = [[YYAccountModel alloc]init];
        model.uid           = resp.uid;
        model.openid        = resp.openid;
        model.accessToken   = resp.accessToken;
        model.refreshToken  = resp.refreshToken;
        model.expiration    = resp.expiration;
        model.nickname      = resp.name;
        model.gender        = resp.unionGender;
        model.iconurl       = resp.iconurl;
        model.originalResponse = resp.originalResponse;
        
        !handler ?: handler(model,error);
    }];
}

+ (void)twitterLoginWithRootView:(UIViewController *)rootView
                completionHandle:(YYLoginBlock)handler {
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
            [client loadUserWithID:[session userID] completion:^(TWTRUser *user, NSError *error) {
                YYAccountModel *model = [YYAccountModel new];
                if (user && !error) {
                    model.nickname = user.name;
                    model.uid = user.userID;
                    model.iconurl = user.profileImageLargeURL;
                    model.accessToken = session.authToken;
                }
                if (handler) {
                    handler(model,error);
                }
            }];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
            if (handler) {
                YYAccountModel *model = [YYAccountModel new];
                handler(model,error);
            }
        }
    }];
}

#pragma mark - share

+ (void)shareTotwitterWithResourcePath:(NSString *)resourcePath
                              rootView:(UIViewController *)rootView{
    NSURL *resourceUrl = [NSURL URLWithString:[NSString stringWithFormat:@"twitter://library?LocalIdentifier=%@",resourcePath]];
    if (@available(iOS 10.0, *)) {
        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
        if ([[UIApplication sharedApplication] canOpenURL:resourceUrl]) {
            [[UIApplication sharedApplication] openURL:resourceUrl options:options completionHandler:nil];
        }
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:resourceUrl]) {
            [[UIApplication sharedApplication] openURL:resourceUrl];
        }
    }
}

+ (void)shareToInstagramWitResourcePath:(NSString *)resourcePath
                               rootView:(UIViewController *)rootView {
    NSURL *resourceUrl = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?LocalIdentifier=%@",resourcePath]];
    if (@available(iOS 10.0, *)) {
        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
        if ([[UIApplication sharedApplication] canOpenURL:resourceUrl]) {
            [[UIApplication sharedApplication] openURL:resourceUrl options:options completionHandler:nil];
        }
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:resourceUrl]) {
            [[UIApplication sharedApplication] openURL:resourceUrl];
        }
    }
}



+ (void)shareWith:(UMSocialPlatformType)platform
       shareModel:(YYShareModel *)model
completionHandler:(YYShareBlock)handler {
    
    NSInteger type = platform;
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:model.title descr:model.descr thumImage:model.thumbURL];
    shareObject.webpageUrl = model.webURL;
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:[self getCurrentVC] completion:^(id data, NSError *error) {
        if (error) {
            !handler ?: handler(NO,error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        } else{
            NSError *error = nil;
            !handler ?: handler(YES,error);
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                UMSocialLogInfo(@"response message is %@; response originalResponse data is %@",resp.message,resp.originalResponse);
            } else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

#pragma mark -

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
