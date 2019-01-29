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
    [YYUMSocialManager loginWith:UMSocialPlatformType_Twitter completionHandler:^(YYAccountModel * model, NSError * error) {
    }];
}

- (IBAction)facebookLogin:(id)sender {
    [YYUMSocialManager loginWith:UMSocialPlatformType_Facebook completionHandler:^(YYAccountModel * model, NSError * error) {
    }];
}

- (IBAction)twitterShare:(id)sender {
    [YYUMSocialManager shareWith:UMSocialPlatformType_Twitter shareModel:self.shareModel completionHandler:^(BOOL isSuccess, NSError * error) {
    }];
}

- (IBAction)facebookShare:(id)sender {
    [YYUMSocialManager shareWith:UMSocialPlatformType_Facebook shareModel:self.shareModel completionHandler:^(BOOL isSuccess, NSError * error) {
    }];
}

- (IBAction)instagramShare:(id)sender {
    [YYUMSocialManager shareWith:UMSocialPlatformType_Instagram shareModel:self.shareModel completionHandler:^(BOOL isSuccess, NSError * error) {
    }];
}


@end
