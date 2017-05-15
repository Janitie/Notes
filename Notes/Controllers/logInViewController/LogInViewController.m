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
    
//    [self loginToWeChat];
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             [self dismissViewControllerAnimated:YES completion:nil];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

- (void)loginToWeChat {
    //  [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
//                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler)
//    {
//        //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
//        //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
//        associateHandler (user.uid, user, user);
//        NSLog(@"dd%@",user.rawData);
//        NSLog(@"dd%@",user.credential);
//    }
//                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error)
//    {
//        if (state == SSDKResponseStateSuccess)
//        {
//            NSLog(@"lalalala");
//        }
//    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
