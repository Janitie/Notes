//
//  TagObject.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/9.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "TagObject.h"

static NSString * KeyName = @"tagName";
//static NSString * KeyColor = @"tagColor";

@implementation TagObject

- (NSString *)className {
    return TagClass;
}

#pragma mark - setter
- (void)setTagName:(NSString *)tagName {
    [self.avObject setObject:tagName forKey:KeyName];
}

//- (void)setTagColor:(colorType)tagColor {
//    [self.avObject setObject:tagColor forKey:KeyColor];
//}

#pragma mark - getter
- (NSString *)tagName {
    return [self.avObject objectForKey:KeyName];
}


@end
