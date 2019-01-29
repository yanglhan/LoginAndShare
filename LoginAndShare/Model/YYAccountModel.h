//
//  YYAccountModel.h
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAccountModel : NSObject

@property(nonatomic,   copy) NSString  *nickname;
@property(nonatomic,   copy) NSString  *iconurl;
@property(nonatomic,   copy) NSString  *gender;

@property(nonatomic,   copy) NSString  *uid;
@property(nonatomic,   copy) NSString  *openid;
@property(nonatomic,   copy) NSString  *accessToken;
@property(nonatomic,   copy) NSString  *refreshToken;
@property(nonatomic, strong) NSDate    *expiration;
//第三方原始数据

@property(nonatomic, strong) id originalResponse;

@end

NS_ASSUME_NONNULL_END
