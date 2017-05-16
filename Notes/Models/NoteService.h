//
//  NoteService.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteObject.h"

@interface NoteService : NSObject


+ (void)creatNewNoteWithTitle:(NSString *)title content:(NSString *)content type:(BOOL)isNote callback:(void(^)(BOOL succeeded))callback;

+ (void)fetchNotes:(NSString *)userId callback:(void (^)(BOOL isSuccess, NSArray<NoteObject *> * results)) callback;

+ (void)deleteWithObjectId:(NSString *)objId callback:(void (^)(BOOL isSuccess))callback;

@end
