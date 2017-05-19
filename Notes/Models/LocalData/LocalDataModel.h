//
//  LocalDataModel.h
//  Notes
//
//  Created by Horace Yuan on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"

#define LocalDataInstance [LocalDataModel instance]

@interface LocalDataModel : NSObject

#pragma mark - data store in cache
/// 当前用户
@property (nonatomic, readonly) UserObject * currentUser;
/// 用户的ID
@property (nonatomic, readonly) NSString * userId;

#pragma mark - data stroe in disk
/// 是否已登录
@property (nonatomic) BOOL isLogin;
/// 当前用户id
@property (nonatomic) NSString * wxOpenId;
/// 微信昵称
@property (nonatomic) NSString * nickName;
/// 微信头像
@property (nonatomic) NSString * userIcon;
/// 当前用户的常用Tags
@property (nonatomic) NSArray * usedTags;

+ (LocalDataModel *) instance;

@end
