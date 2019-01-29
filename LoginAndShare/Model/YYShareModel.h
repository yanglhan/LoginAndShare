//
//  YYShareModel.h
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYShareModel : NSObject


/**
 缩略图
 */
@property(nonatomic, copy)NSString *thumbURL;

/**
 标题
 */
@property(nonatomic, copy)NSString *title;

/**
 描述
 */
@property(nonatomic, copy)NSString *descr;

/**
 跳转URL
 */
@property(nonatomic, copy)NSString *webURL;

@end

NS_ASSUME_NONNULL_END
