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


@interface userObject : NSObject

@property (nonatomic, strong, readonly) AVUser * user;

/// wxopenid
@property (nonatomic) NSString * username;      //name
@property (nonatomic) NSString * wxopenId;      //id
@property (nonatomic) NSString * iconUrl;       //face
//@property (nonatomic) GenderType genderType;    //gender

- (NSString *)updateAt;
- (NSString *)createAt;


+ (instancetype)newUser;
+ (instancetype)currentUser;
+ (instancetype)userWithUser:(AVUser *)user;

@end
