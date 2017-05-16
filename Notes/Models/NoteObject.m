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

static NSString * keyisNote = @"isNote";
static NSString * keyisComplete = @"isComplete";
static NSString * keyisShared = @"isShared";

@implementation NoteObject

- (NSString *)className {
    return NoteClass;
}

#pragma mark - setter

- (void) setTitle:(NSString *)title {
    [self.avObject setObject:title forKey:KeyTitle];
}

- (void)setContent:(NSString *)content {
    [self.avObject setObject:content forKey:KeyContent];
}

- (void)setAuthorId:(NSString *)authorId {
    [self.avObject setObject:authorId forKey:KeyAuthor];
}

- (void)setIsNote:(BOOL)isNote {
    [self.avObject setObject:[NSNumber numberWithBool:isNote] forKey:keyisNote];
}

- (void)setIsComplete:(BOOL)isComplete {
    [self.avObject setObject:[NSNumber numberWithBool:isComplete] forKey:keyisComplete];
}

- (void)setIsShared:(BOOL)isShared {
    [self.avObject setObject:[NSNumber numberWithBool:isShared] forKey:keyisShared];
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

- (BOOL)isNote {
    return [self.avObject objectForKey:keyisNote];
}

- (BOOL)isComplete {
    return [self.avObject objectForKey:keyisComplete];
}

- (BOOL)isShared {
    return [self.avObject objectForKey:keyisShared];
}


@end
