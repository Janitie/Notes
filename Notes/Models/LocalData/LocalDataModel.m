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
- (BOOL)isLogin {
    return [self.mUserDefault boolForKey:@"isLogin"];
}

- (NSString *)userId {
    return [self.mUserDefault valueForKey:@"userId"];
}


- (NSArray *)usedTags {
    return [self.mUserDefault valueForKey:@"usedTags"];
}
#pragma mark - Setter
- (void)setIsLogin:(BOOL)isLogin {
    [self.mUserDefault setBool:isLogin forKey:@"isLogin"];
}

- (void)setUserId:(NSString *)userId {
    [self.mUserDefault setValue:userId forKey:@"userId"];
}

- (void)setUsedTags:(NSArray *)usedTags {
    [self.mUserDefault setValue:usedTags forKey:@"usedTags"];
}


@end
