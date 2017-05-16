//
//  ReaderObject.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "ReaderObject.h"

static NSString * KeyUser = @"userId";
static NSString * KeyNote = @"noteId";

@implementation ReaderObject

- (NSString *)className {
    return ReaderClass;
}

#pragma mark - setter
- (void)setNoteId:(NSString *)noteId {
    [self.avObject setObject:noteId forKey:KeyNote];
}

- (void)setUserId:(NSString *)userId {
    [self.avObject setObject:userId forKey:KeyUser];
}

#pragma mark - getter
- (NSString *)noteId {
    return [self.avObject objectForKey:KeyNote];
}

- (NSString *)userId {
    return [self.avObject objectForKey:KeyUser];
}

@end
