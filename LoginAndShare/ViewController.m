//
//  ViewController.m
//  LoginAndShare
//
//  Created by yang on 2018/10/23.
//  Copyright © 2018年 yang123. All rights reserved.
//

#import "ViewController.h"
#import "YYUMSocialManager.h"
#import <UMShare/UMShare.h>

@interface ViewController ()
@property (nonatomic, strong) YYShareModel *shareModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shareModel = [[YYShareModel alloc] init];
}

- (IBAction)twitterLogin:(id)sender {
    [YYUMSocialManager twitterLoginWithRootView:self completionHandle:^(YYAccountModel * model, NSError * error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            /** 打印 model 信息*/
        }
    }];
}

- (IBAction)facebookLogin:(id)sender {
    [YYUMSocialManager loginWith:UMSocialPlatformType_Facebook completionHandler:^(YYAccountModel * model, NSError * error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            /** model*/
        }
    }];
}

- (IBAction)twitterShare:(id)sender {
    /** 跳转分享*/
    [YYUMSocialManager shareTotwitterWithResourcePath:@"" rootView:self];
}

- (IBAction)facebookShare:(id)sender {
    [YYUMSocialManager shareWith:UMSocialPlatformType_Facebook shareModel:self.shareModel completionHandler:^(BOOL isSuccess, NSError * error) {
        if (isSuccess && error == nil) {
            NSLog(@"跳转成功");
        } else {
            NSLog(@"跳转失败");
        }
    }];
}

- (IBAction)instagramShare:(id)sender {
    /** 跳转分享*/
    [YYUMSocialManager shareToInstagramWitResourcePath:@"" rootView:self];
}


@end
