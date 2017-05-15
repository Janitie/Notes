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

- (NSString *)className
{
    return UserClass;
}

+ (instancetype)currentUser {
    return [[self class] new];
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
    [self.user setValue:username forKey:KeyName];
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
    return [self.user objectForKey:KeyName];
}

- (NSString *)iconUrl {
    return [self.user objectForKey:KeyIcon];
}

- (NSString *)wxopenId {
    return [self.user objectForKey:KeyWxid];
}



@end
