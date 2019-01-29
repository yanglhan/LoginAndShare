//
//  YYUMSocialManager.h
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
#import "YYShareModel.h"
#import "YYAccountModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^YYLoginBlock)(YYAccountModel *, NSError *);
typedef void (^YYShareBlock)(BOOL, NSError *);
@interface YYUMSocialManager : NSObject

/**
 友盟SDK 注册
 
 @param umSocialAppkey 友盟应用Appkey
 */
+ (void)setUmSocialAppkey:(NSString *)umSocialAppkey
                  openLog:(BOOL)isLog;

/**
 第三方授权登录
 
 @param platform 第三方平台
 @param handler 回调
 */
+ (void)loginWith:(UMSocialPlatformType)platform
completionHandler:(YYLoginBlock)handler;

/**
 社会化分享
 
 @param platform 第三方平台
 @param model 分享内容
 @param handler 回调
 */
+ (void)shareWith:(UMSocialPlatformType)platform
       shareModel:(YYShareModel *)model
completionHandler:(YYShareBlock)handler;

/**
 直接分享
 @param platform 第三方平台 （YouTube & Facebook）
 @param url 本地视频链接
 @param handler 回调
 */


@end

NS_ASSUME_NONNULL_END
