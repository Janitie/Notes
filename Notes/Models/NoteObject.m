//
//  NoteObject.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/8.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "NoteObject.h"

static NSString * KeyTitle = @"title";
static NSString * KeyContent = @"content";
static NSString * KeyAuthor = @"authorId";

@implementation NoteObject

- (NSString *)className {
    return NoteClass;
}

#pragma mark - setter
//- (void)test {
//    
//    self.title = @"";
//    NSLog(@"%@", self.title);
//}

- (void) setTitle:(NSString *)title {
    [self.avObject setObject:title forKey:KeyTitle];
}

- (void)setContent:(NSString *)content {
    [self.avObject setObject:content forKey:KeyContent];
}

- (void)setAuthorId:(NSString *)authorId {
    [self.avObject setObject:authorId forKey:KeyAuthor];
}

#pragma mark - getter
- (NSString *)title {
    return [self.avObject objectForKey:KeyTitle];
}

- (NSString *)content {
    return [self.avObject objectForKey:KeyContent];
}

- (NSString *)authorId {
    return [self.avObject objectForKey:KeyAuthor];
}


@end
