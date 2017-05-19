//
//  LocalDataModel.m
//  Notes
//
//  Created by Horace Yuan on 2017/5/17.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "LocalDataModel.h"

@interface LocalDataModel ()

@property (nonatomic, readonly) NSUserDefaults * mUserDefault;

@end

@implementation LocalDataModel

+ (LocalDataModel *)instance {
    static dispatch_once_t onceToken;
    static LocalDataModel * s_instance = nil;
    dispatch_once(&onceToken, ^{
        s_instance = [LocalDataModel new];
    });
    return s_instance;
}

#pragma mark - Base
- (NSUserDefaults *)mUserDefault {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - Getter
- (UserObject *)currentUser {
    return [UserObject currentUser];
}

- (NSString *)userId {
    return self.currentUser.objectId;
}

- (BOOL)isLogin {
    return [self.mUserDefault boolForKey:@"isLogin"];
}

- (NSString *)wxOpenId {
    return [self.mUserDefault valueForKey:@"wxOpenId"];
}

- (NSString *)nickName {
    return [self.mUserDefault valueForKey:@"nickName"];
}

- (NSString *)userIcon {
    return [self.mUserDefault valueForKey:@"userIcon"];
}

- (NSArray *)usedTags {
    return [self.mUserDefault valueForKey:@"usedTags"];
}

#pragma mark - Setter
- (void)setIsLogin:(BOOL)isLogin {
    [self.mUserDefault setBool:isLogin forKey:@"isLogin"];
    [self.mUserDefault synchronize];
}

- (void)setWxOpenId:(NSString *)wxOpenId {
    [self.mUserDefault setValue:wxOpenId forKey:@"wxOpenId"];
    [self.mUserDefault synchronize];
}

- (void)setNickName:(NSString *)nickName {
    [self.mUserDefault setValue:nickName forKey:@"nickName"];
    [self.mUserDefault synchronize];
}

- (void)setUserIcon:(NSString *)userIcon {
    [self.mUserDefault setValue:userIcon forKey:@"userIcon"];
    [self.mUserDefault synchronize];
}

- (void)setUsedTags:(NSArray *)usedTags {
    [self.mUserDefault setValue:usedTags forKey:@"usedTags"];
    [self.mUserDefault synchronize];
}


@end
