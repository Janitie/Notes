//
//  userObject.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/8.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "userObject.h"


static NSString * KeyName = @"username";
static NSString * KeyWxid = @"wxopenId";
static NSString * KeyIcon = @"iconUrl";
//static NSString * KeyGender = @"genderType";

@interface userObject ()

@property (nonatomic, strong) AVUser * user;

@end

@implementation userObject

- (id) init
{
    self = [super init];
    if (self) {
        self.user = [AVUser currentUser];
    }
    return self;
}

+ (instancetype)newUser {
    userObject *newUser = [userObject new];
    newUser.user = [AVUser user];
    return newUser;
}

+ (instancetype)currentUser {
    userObject * currentUser = [userObject new];
    currentUser.user = [AVUser currentUser];
    if (currentUser.user){
        return currentUser;
    } else {
        return NULL;
    }
}

+ (instancetype)userWithUser:(AVUser *)user
{
    userObject * existUser = [userObject new];
    existUser.user = user;
    return existUser;
}

#pragma mark - Methods

- (NSString *)className
{
    return UserClass;
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

- (void)setWxopenId:(NSString *)wxopenId {
    [self.user setValue:wxopenId forKey:KeyWxid];
}

- (void)setIconUrl:(NSString *)iconUrl {
    [self.user setValue:iconUrl forKey:KeyIcon];
}

//- (void)setGenderType:(GenderType)genderType {
//    [self.user setValue:genderType forKey:KeyGender];
//}


#pragma mark - getter
- (NSString *)username {
    return self.user.username;
}

- (NSString *)iconUrl {
    return [self.user objectForKey:KeyIcon];
}

- (NSString *)wxopenId {
    return [self.user objectForKey:KeyWxid];
}



@end
