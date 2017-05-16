//
//  NoteObject.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/8.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import "BaseDataModel.h"

static NSString * NoteClass = @"Note";

@interface NoteObject : BaseDataModel

@property (nonatomic) NSString * title;
@property (nonatomic) NSString * content;
@property (nonatomic) NSString * authorId;

@property (nonatomic) BOOL isNote;
@property (nonatomic) BOOL isComplete;
@property (nonatomic) BOOL isShared;
@end
