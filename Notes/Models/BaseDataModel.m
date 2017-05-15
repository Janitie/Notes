//
//  BaseDataModel.m
//  Lovers
//
//  Created by 徐琬璇 on 2017/1/1.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "BaseDataModel.h"

@interface BaseDataModel ()

@property (nonatomic, strong) AVObject * avObject;

@end

@implementation BaseDataModel

- (id) init
{
    self = [super init];
    if (self) {
        self.avObject = [AVObject objectWithClassName:[self className]];
    }
    return self;
}

- (instancetype) initWithAVObject:(AVObject *)object
{
    self = [super init];
    if (self) {
        self.avObject = object;
    }
    return self;
}

- (NSString *)className
{
    return @"baseClassName";
}

+ (instancetype)newObject
{
    return [[self class] new];
}

+ (instancetype)objectWithObject:(AVObject *)object
{
    if (object) {
        return [[[self class] alloc] initWithAVObject:object];
    } else {
        return nil;
    }
}

- (NSString *)createAt
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self.avObject.createdAt];
}

- (NSString *)updateAt
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self.avObject.updatedAt];
}

@end
