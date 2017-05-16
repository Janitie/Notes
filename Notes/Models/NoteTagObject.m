//
//  NoteTagObject.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "NoteTagObject.h"

static NSString * KeyNote = @"noteId";
static NSString * KeyTag = @"tagId";

@implementation NoteTagObject

- (NSString *)className {
    return NoteTagClass;
}

#pragma mark - setter
- (void)setNoteId:(NSString *)noteId {
    [self.avObject setObject:noteId forKey:KeyNote];
}

- (void)setTagId:(NSString *)tagId {
    [self.avObject setObject:tagId forKey:KeyTag];
}

#pragma mark - getter
- (NSString *)noteId {
    return [self.avObject objectForKey:KeyNote];
}

- (NSString *)tagId {
    return [self.avObject objectForKey:KeyTag];
}

@end
