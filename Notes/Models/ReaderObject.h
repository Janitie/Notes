//
//  ReaderObject.h
//  Notes
//
//  Created by 徐琬璇 on 2017/5/10.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "BaseDataModel.h"

static NSString * ReaderClass = @"Reader";

@interface ReaderObject : BaseDataModel

@property (nonatomic) NSString * userId;
@property (nonatomic) NSString * noteId;

@end
