//
//  NoteTagObject.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "BaseDataModel.h"

static NSString * NoteTagClass = @"NoteTag";

@interface NoteTagObject : BaseDataModel

@property (nonatomic) NSString * noteId;
@property (nonatomic) NSString * tagId;

@end
