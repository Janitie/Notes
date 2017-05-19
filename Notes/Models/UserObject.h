//
//  userObject.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/8.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

static NSString * UserClass = @"_User";

//typedef enum : NSUInteger {
//    Male = 1,
//    Female = 0
//} GenderType;


@interface UserObject : NSObject

@property (nonatomic, strong, readonly) AVUser * user;

@property (nonatomic) NSString * username;      //un -> wxOpenId
@property (nonatomic) NSString * password;      //pw
@property (nonatomic) NSString * nickName;      //nickname
@property (nonatomic) NSString * iconUrl;       //face

@property (nonatomic, readonly) NSString * objectId;

- (NSString *)updateAt;
- (NSString *)createAt;


+ (instancetype)newUser;
+ (instancetype)currentUser;
+ (instancetype)userWithUser:(AVUser *)user;

@end
