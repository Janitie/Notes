//
//  LocalDataModel.h
//  Notes
//
//  Created by Horace Yuan on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LocalDataInstance [LocalDataModel instance]

@interface LocalDataModel : NSObject

/// 是否已登录
@property (nonatomic) BOOL isLogin;
/// 当前用户id
@property (nonatomic) NSString * userId;
/// 当前用户的常用Tags
@property (nonatomic) NSArray * usedTags;

+ (LocalDataModel *) instance;

@end
