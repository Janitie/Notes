//
//  UserService.m
//  Notes
//
//  Created by Horace Yuan on 2017/5/18.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "UserService.h"

#define DefaultPassword @"888888"

@implementation UserService

// 注册用户
+ (void)registerUserWXToken:(NSString *)wxToken
                   nickName:(NSString *)nickName
                       icon:(NSString *)icon
                   callback:(void (^)(BOOL isSuccess))callback
{
    UserObject * newUser = [UserObject newUser];
    newUser.username = wxToken;
    newUser.password = DefaultPassword;
    newUser.nickName = nickName;
    newUser.iconUrl = icon;
    [newUser.user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (callback) {
            callback(succeeded);
        }
    }];
}

// 用户登录
+ (void)loginUserWithWXToken:(NSString *)wxToken
                    nickName:(NSString *)nickName
                        icon:(NSString *)icon
                    callback:(void (^)(BOOL isSuccess))callback
{
    if (!callback) return;
    
    [AVUser logInWithUsernameInBackground:wxToken
                                 password:DefaultPassword
                                    block:^(AVUser * _Nullable user, NSError * _Nullable error)
    {
        if (!user || error.code == 211) {
            // 用户不存在
            [self registerUserWXToken:wxToken
                             nickName:nickName
                                 icon:icon
                             callback:^(BOOL isSuccess) {
                                 callback(isSuccess);
                             }];
        } else {
            LocalDataInstance.isLogin = YES;
            LocalDataInstance.wxOpenId = wxToken;
            LocalDataInstance.userIcon = icon;
            LocalDataInstance.nickName = nickName;
            callback (YES);
        }
    }];
}

// 用户注销
+ (void)logout
{
    [AVUser logOut];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    LocalDataInstance.isLogin = NO;
    LocalDataInstance.wxOpenId = nil;
    LocalDataInstance.userIcon = nil;
    LocalDataInstance.nickName = nil;
    LocalDataInstance.usedTags = nil;
}

@end
