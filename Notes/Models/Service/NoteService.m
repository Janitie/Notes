//
//  NoteService.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "NoteService.h"

@implementation NoteService

+ (void)creatNewNoteWithTitle:(NSString *)title content:(NSString *)content
                         type:(BOOL)isNote callback:(void (^)(BOOL))callback {
    NoteObject * newNote = [NoteObject newObject];
    newNote.title = title;
    newNote.content = content;
    newNote.isNote = isNote;
    newNote.isComplete = NO;
    newNote.isShared = NO;

    [newNote.avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self addReaderWithNoteId:newNote.objectId
                             callback:callback];
        }
        else {
            callback(NO);
        }
    }];
}

+ (void)addReaderWithNoteId:(NSString *)noteId
                   callback:(void(^)(BOOL isSuccess))callback
{
    ReaderObject * readerObject = [ReaderObject newObject];
    readerObject.noteId = noteId;
    readerObject.userId = LocalDataInstance.userId;
    [readerObject.avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
     {
         callback (succeeded);
     }];
}


+ (void)fetchNotes:(NSString *)userId callback:(void (^)(BOOL isSuccess, NSArray<NoteObject *> * results)) callback {
//    AVQuery *query = [AVQuery queryWithClassName:NoteClass];
////    [query whereKey:@"userId" equalTo:userId];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (error) {
//            callback (NO, nil);
//        } else {
//            NSMutableArray * objectResults = [NSMutableArray array];
//            for (AVObject * avObj in objects) {
//                NoteObject * obj = [NoteObject objectWithObject:avObj];
//                [objectResults addObject:obj];
//            }
//            callback (YES, objectResults);
//        }
//    }];
    AVQuery * query = [ReaderObject query];
    [query whereKey:@"userId" equalTo:userId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSMutableArray * noteObjs = [NSMutableArray array];
            for (AVObject * obj in objects) {
                ReaderObject * reader = [[ReaderObject alloc] initWithAVObject:obj];
                NoteObject * noteObj = [NoteObject newObjectWithObjectId:reader.noteId];
                [noteObjs addObject:noteObj.avObject];
            }
            [AVObject fetchAllInBackground:noteObjs
                                     block:^(NSArray * _Nullable objects, NSError * _Nullable error)
            {
                if (!error) {
                    NSMutableArray * notesResult = [NSMutableArray array];
                    for (AVObject * avObj in objects) {
                        NoteObject *noteObj = [[NoteObject alloc] initWithAVObject:avObj];
                        [notesResult addObject:noteObj];
                    }
                    callback (YES, notesResult);
                } else {
                    callback (NO, nil);
                }
            }];
        } else {
            callback (NO, nil);
        }
    }];
    
}

+ (void)findInNoteBoxWithObjId:(NSString *)objId Callback:(void (^)(BOOL succeeded,NoteObject * noteObject))callback {
    AVQuery * query = [AVQuery queryWithClassName:NoteClass];
    [query whereKey:@"objectId" equalTo:objId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects && objects.count > 0) {
            NoteObject * note = [NoteObject objectWithObject:objects[0]];
            callback(YES,note);
        }
        else {
            callback(NO,nil);
        }
    }];
}

+ (void)deleteWithObjectId:(NSString *)objId
                  callback:(void (^)(BOOL))callback {
    NSString * queryCQL = [NSString stringWithFormat:@"delete from %@ where objectId='%@'",NoteClass,objId];

    [AVQuery doCloudQueryInBackgroundWithCQL:queryCQL
                                    callback:^(AVCloudQueryResult * _Nullable result, NSError * _Nullable error) {
                                        if (error == nil) {
                                            callback(YES);
                                        }
                                        else {
                                            callback(NO);
                                        }
                                    }];
}

+ (void)updateTitle:(NSString *)newTitle Content:(NSString *)newContent
       WithObjectId:(NSString *)objId callback:(void (^)(BOOL))callback {
    [self findInNoteBoxWithObjId:objId
                        Callback:^(BOOL succeeded, NoteObject *noteObject) {
                            if (succeeded) {
                                noteObject.title = newTitle;
                                noteObject.content = newContent;
                                [noteObject.avObject
                                 saveInBackgroundWithBlock:^(BOOL succeeded,
                                                             NSError * _Nullable error) {
                                    if (succeeded) {
                                        callback(YES);
                                    }
                                    else {
                                        callback(error);
                                    }
                                }];
                            }
                        }];
}

#pragma mark - Tags

/// 添加新Tag
+ (void)addNewTag:(NSString *)tagTitle callback:(void (^)(BOOL isSuccess, TagObject * object))callback {
    if (LocalDataInstance.isLogin) {
        TagObject * tagObject = [TagObject newObject];
        tagObject.userId = LocalDataInstance.currentUser.objectId;
        tagObject.tagName = tagTitle;
        [tagObject.avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (!error) {
                callback (YES, tagObject);
            } else {
                callback (NO, tagObject);
            }
        }];
    } else {
        callback(NO, nil);
    }
}

/// 删除Tag
+ (void)deleteTag:(NSString *)tagId callback:(void (^)(BOOL isSuccess))callback {
    AVQuery *query = [TagObject query];
    [query getObjectInBackgroundWithId:tagId
                                 block:^(AVObject * _Nullable object, NSError * _Nullable error)
    {
        if (object != nil) {
            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                callback (succeeded);
            }];
        } else {
            callback (YES);
        }
    }];
}

/// 获取用户的标签
+ (void)getTagsWithUserId:(NSString *)userId callback:(void (^)(NSArray<TagObject *> * result))callback {
    AVQuery * query = [TagObject query];
    [query whereKey:@"userId" equalTo:userId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSMutableArray * results = [NSMutableArray array];
            for (AVObject * avObj in objects) {
                TagObject * tagObj = [[TagObject alloc] initWithAVObject:avObj];
                [results addObject:tagObj];
            }
            callback (results);
        } else {
            callback (nil);
        }
    }];
}

/// 获取文章的标签
+ (void)getTagsWithNoteId:(NSString *)noteId callback:(void (^)(NSArray<TagObject *> * result))callback {
    AVQuery * query = [NoteTagObject query];
    [query whereKey:@"noteId" equalTo:noteId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects && objects.count > 0) {
            NSMutableArray * tagObjects = [NSMutableArray array];
            for (AVObject * avObj in objects) {
                NoteTagObject * obj = [[NoteTagObject alloc] initWithAVObject:avObj];
                TagObject * tagObj = [TagObject newObjectWithObjectId:obj.tagId];
                [tagObjects addObject:tagObj.avObject];
            }
            [AVObject fetchAllInBackground:tagObjects
                                     block:^(NSArray * _Nullable objects, NSError * _Nullable error)
            {
                if (!error) {
                    NSMutableArray * tagResults = [NSMutableArray array];
                    for (AVObject * avObj in objects) {
                        TagObject * tagObj = [[TagObject alloc] initWithAVObject:avObj];
                        [tagResults addObject:tagObj];
                    }
                    callback (tagResults);
                } else {
                    callback (nil);
                }
            }];
        } else {
            callback (nil);
        }
    }];
}

/// 添加文章标签
+ (void)addNoteTagWithNoteId:(NSString *)noteId
                       tagId:(NSString *)tagId
                    callback:(void (^)(BOOL isSuccess))callback
{
    AVQuery * query = [NoteTagObject query];
    [query whereKey:@"noteId" equalTo:noteId];
    [query whereKey:@"tagId" equalTo:tagId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error)
    {
        if (objects.count <= 0) {
            NoteTagObject * obj = [NoteTagObject newObject];
            obj.noteId = noteId;
            obj.tagId = tagId;
            [obj.avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
            {
                callback(succeeded);
            }];
        } else {
            callback (YES);
        }
    }];
}

/// 删除文章标签
+ (void)deleteNoteTagWithNoteId:(NSString *)noteId
                          TagId:(NSString *)tagId
                       callback:(void (^)(BOOL isSuccess))callback
{
    AVQuery * query = [NoteTagObject query];
    [query whereKey:@"noteId" equalTo:noteId];
    [query whereKey:@"tagId" equalTo:tagId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error)
    {
        if (objects.count > 0) {
            [AVObject deleteAllInBackground:objects
                                      block:^(BOOL succeeded, NSError * _Nullable error)
            {
                callback(succeeded);
            }];
        } else {
            callback (YES);
        }
    }];
}


@end
