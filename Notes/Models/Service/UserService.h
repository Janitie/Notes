//
//  UserService.h
//  Notes
//
//  Created by Horace Yuan on 2017/5/18.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "UserObject.h"

@interface UserService : NSObject

// 注册用户
+ (void)registerUserWXToken:(NSString *)wxToken
                   nickName:(NSString *)nickName
                       icon:(NSString *)icon
                   callback:(void (^)(BOOL isSuccess))callback;

// 用户登录
+ (void)loginUserWithWXToken:(NSString *)wxToken
                    nickName:(NSString *)nickName
                        icon:(NSString *)icon
                    callback:(void (^)(BOOL isSuccess))callback;

// 用户注销
+ (void)logout;

@end
