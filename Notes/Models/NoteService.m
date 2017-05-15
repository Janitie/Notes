//
//  NoteService.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "NoteService.h"

@implementation NoteService

+ (void)creatNewNoteWithTitle:(NSString *)title content:(NSString *)content callback:(void (^)(BOOL))callback {
    NoteObject * newNote = [NoteObject newObject];
    newNote.title = title;
    newNote.content = content;

    [newNote.avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            callback(YES);
        }
        else {
            callback(error);
        }
    }];
    
//    NoteObject * newCheck = [CheckObject newObject];
//    newCheck.title = title;
//    newCheck.finishTime = fTime;
//    newCheck.user = [UserObject currentUser].user;
//    newCheck.isComplete = NO;
//    
//    [newCheck.avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            callback(YES);
//        }
//        else {
//            callback(error);
//        }
//    }];

}

@end
