//
//  UserObject.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/8.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "UserObject.h"


static NSString * KeyNickName = @"nickName";
static NSString * KeyWxid = @"wxopenId";
static NSString * KeyIcon = @"iconUrl";
//static NSString * KeyGender = @"genderType";

@interface UserObject ()

@property (nonatomic, strong) AVUser * user;

@end

@implementation UserObject

- (id) init
{
    self = [super init];
    if (self) {
        self.user = [AVUser currentUser];
    }
    return self;
}

+ (instancetype)newUser {
    UserObject *newUser = [UserObject new];
    newUser.user = [AVUser user];
    return newUser;
}

+ (instancetype)currentUser {
    UserObject * currentUser = [UserObject new];
    currentUser.user = [AVUser currentUser];
    if (currentUser.user){
        return currentUser;
    } else {
        return NULL;
    }
}

+ (instancetype)userWithUser:(AVUser *)user
{
    UserObject * existUser = [UserObject new];
    existUser.user = user;
    return existUser;
}

#pragma mark - Methods

- (NSString *)className
{
    return UserClass;
}

- (NSString *)objectId {
    return self.user.objectId;
}

- (NSString *)createAt
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self.user.createdAt];
}

- (NSString *)updateAt
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self.user.updatedAt];
}

#pragma mark - setter
- (void)setUsername:(NSString *)username {
    self.user.username = username;
}

- (void)setPassword:(NSString *)password {
    self.user.password = password;
}

- (void)setNickName:(NSString *)nickName {
    [self.user setObject:nickName forKey:KeyNickName];
}

- (void)setIconUrl:(NSString *)iconUrl {
    [self.user setObject:iconUrl forKey:KeyIcon];
}


#pragma mark - getter
- (NSString *)username {
    return self.user.username;
}

- (NSString *)password {
    return self.user.password;
}

- (NSString *)nickName {
    return [self.user objectForKey:KeyNickName];
}

- (NSString *)iconUrl {
    return [self.user objectForKey:KeyIcon];
}




@end
