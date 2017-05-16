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
            callback(NO);
        }
    }];

}

+ (void)fetchNotes:(NSString *)userId callback:(void (^)(BOOL isSuccess, NSArray<NoteObject *> * results)) callback {
    AVQuery *query = [AVQuery queryWithClassName:NoteClass];
//    [query whereKey:@"userId" equalTo:userId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            callback (NO, nil);
        } else {
            NSMutableArray * objectResults = [NSMutableArray array];
            for (AVObject * avObj in objects) {
                NoteObject * obj = [NoteObject objectWithObject:avObj];
                [objectResults addObject:obj];
            }
            callback (YES, objectResults);
        }
    }];
}

@end
