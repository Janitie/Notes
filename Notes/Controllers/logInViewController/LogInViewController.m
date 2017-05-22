//
//  LogInViewController.m
//  Notes
//
//  Created by 徐琬璇 on 2017/4/28.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "LogInViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

#import "UserService.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    
    if (TARGET_IPHONE_SIMULATOR) {
        NSString * token = @"oBYXeweEz8Ki-wgSGrcvAXD3aB_8";
        NSString * userNickName = @"🍍菠萝Ho";
        NSString * userIcon = @"http://wx.qlogo.cn/mmopen/9ouYBkEg8pcfpUZt9JrjgSypXaMZibQ09x9dAKhOadhLd3WThfEbicAmKcBoPTueEZDtDO3PnJNy97ae0SwwURo0mY3mo5aDnQ/0";
        [self loginUser:token
               nickName:userNickName
                   icon:userIcon];
    } else {
        [self loginToWeChat:nil];
    }
}

- (void)loginToWeChat:(SSDKGetUserStateChangedHandler)handle {
    WS(weakSelf);
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
    {
        if (state == SSDKResponseStateSuccess) {
            [weakSelf loginUser:user.credential.uid
                       nickName:user.nickname
                           icon:user.icon];
        } else {
            NSLog(@"%@", error);
        }
    }];
}


- (void)loginUser:(NSString *)token
         nickName:(NSString *)nickName
             icon:(NSString *)userIcon
{
    [MBProgressHUD showWaitingHUDInKeyWindow];
    [UserService loginUserWithWXToken:token
                             nickName:nickName
                                 icon:userIcon
                             callback:^(BOOL isSuccess)
    {
        [MBProgressHUD hideAllWaitingHUDInKeyWindow];
        if (isSuccess) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [MBProgressHUD showQuickTipWithText:@"登录失败"];
        }
    }];
}

@end
