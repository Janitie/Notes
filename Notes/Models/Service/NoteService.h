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

/// 创建笔记
+ (void)creatNewNoteWithTitle:(NSString *)title
                      content:(NSString *)content
                         type:(BOOL)isNote
                     callback:(void(^)(BOOL succeeded, NoteObject * object))callback;

/// 订阅笔记
+ (void)addReaderWithNoteId:(NSString *)noteId
                   callback:(void(^)(BOOL isSuccess))callback;

/// 获取用户可读笔记
+ (void)fetchNotes:(NSString *)userId
          callback:(void (^)(BOOL isSuccess, NSArray<NoteObject *> * results)) callback;

/// 删除笔记
+ (void)deleteWithObjectId:(NSString *)objId
                  callback:(void (^)(BOOL isSuccess))callback;

/// 删除笔记关联
+ (void)deleteReaderWithNoteId:(NSString *)noteId
                      callback:(void (^)(BOOL isSuccess))callback;

/// 更新笔记
+ (void)updateTitle:(NSString *)newTitle
            Content:(NSString *)newContent
       WithObjectId:(NSString *)objId callback:(void (^)(BOOL))callback;

/// 添加新Tag
+ (void)addNewTag:(NSString *)tagTitle
         callback:(void (^)(BOOL isSuccess, TagObject * object))callback;

/// 批量添加Tags
+ (void)addTagsWithTitles:(NSArray *)tagTitles callback:(void (^)(BOOL isSuccess, NSArray<TagObject *> * objects))callback;

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

/// 用新的标签列表替换所有文章标签
+ (void)updateNoteTags:(NSArray<TagObject *> *)tags
                noteId:(NSString *)noteId
              callback:(void (^)(BOOL isSuccess))callback;


@end
