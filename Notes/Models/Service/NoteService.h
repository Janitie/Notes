//
//  NoteService.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteObject.h"
#import "TagObject.h"
#import "NoteTagObject.h"
#import "ReaderObject.h"

@interface NoteService : NSObject


+ (void)creatNewNoteWithTitle:(NSString *)title content:(NSString *)content type:(BOOL)isNote callback:(void(^)(BOOL succeeded))callback;

+ (void)fetchNotes:(NSString *)userId callback:(void (^)(BOOL isSuccess, NSArray<NoteObject *> * results)) callback;

+ (void)deleteWithObjectId:(NSString *)objId callback:(void (^)(BOOL isSuccess))callback;

+ (void)updateTitle:(NSString *)newTitle Content:(NSString *)newContent WithObjectId:(NSString *)objId callback:(void (^)(BOOL))callback;

/// 添加新Tag
+ (void)addNewTag:(NSString *)tagTitle
         callback:(void (^)(BOOL isSuccess, TagObject * object))callback;
/// 删除Tag
+ (void)deleteTag:(NSString *)tagId
         callback:(void (^)(BOOL isSuccess))callback;
/// 获取用户的标签
+ (void)getTagsWithUserId:(NSString *)userId
                 callback:(void (^)(NSArray<TagObject *> * result))callback;
/// 获取文章的标签
+ (void)getTagsWithNoteId:(NSString *)noteId
                 callback:(void (^)(NSArray<TagObject *> * result))callback;

/// 添加文章标签
+ (void)addNoteTagWithNoteId:(NSString *)noteId
                       tagId:(NSString *)tagId
                    callback:(void (^)(BOOL isSuccess))callback;
/// 删除文章标签
+ (void)deleteNoteTagWithNoteId:(NSString *)noteId
                          TagId:(NSString *)tagId
                       callback:(void (^)(BOOL isSuccess))callback;


@end
