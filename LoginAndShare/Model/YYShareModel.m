//
//  YYShareModel.m
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "YYShareModel.h"

@implementation YYShareModel

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"标题....";
        self.descr = @"描述....";
        self.webURL = @"https://www.baidu.com";
        self.thumbURL = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    }
    return self;
}

@end
