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

- (instancetype)initWithObjectId:(NSString *)objectId
{
    self = [super init];
    if (self) {
        self.avObject = [AVObject objectWithClassName:[self className]
                                             objectId:objectId];
    }
    return self;
}

- (NSString *)className
{
    return @"baseClassName";
}

+ (AVQuery *)query {
    return [AVQuery queryWithClassName:[[[self class] new] className]];
}

+ (instancetype)newObject
{
    return [[self class] new];
}

+ (instancetype)newObjectWithObjectId:(NSString *)objectId
{
    return [[[self class] alloc] initWithObjectId:objectId];
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
    formatter.dateFormat = @"yyyy.MM.dd";
    return [formatter stringFromDate:self.avObject.createdAt];
}

- (NSString *)updateAt
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy.MM.dd";
    return [formatter stringFromDate:self.avObject.updatedAt];
}

- (NSString *)objectId {
    return [self.avObject objectId];
}

@end
