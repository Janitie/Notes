//
//  BaseDataModel.h
//  Lovers
//
//  Created by 徐琬璇 on 2017/1/1.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@protocol BaseDataProtocol <NSObject>

- (NSString *) className;

@end

@interface BaseDataModel : NSObject <BaseDataProtocol>

@property (nonatomic, strong, readonly) AVObject * avObject;
@property (nonatomic, readonly) NSString * createAt;
@property (nonatomic, readonly) NSString * updateAt;

+ (instancetype) newObject;
+ (instancetype) objectWithObject: (AVObject *)object;

- (instancetype) initWithAVObject: (AVObject *)object;

@end
